import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../models/button_type.dart';
import '../models/calc_button.dart';

// ignore: constant_identifier_names
enum DegRad { DEG, RAD }

@singleton
class DisplayService with ReactiveServiceMixin {
  /// contains either [CalcButton]s, that are operators or numbers
  /// that are in [String] form.
  final _calculation = ReactiveValue<List<dynamic>>(['']);
  final _degRad = ReactiveValue<DegRad>(DegRad.DEG);
  final _result = ReactiveValue<String>('');
  String get current => _calculation.value.map((e) => e.toString()).join(' ');
  DegRad get degRad => _degRad.value;
  String get result => _result.value;

  DisplayService() {
    listenToReactiveValues([_calculation, _degRad, _result]);
  }

  void _reconcileBrackets() {
    var c = _calculation.value;
    int opens = 0;
    int closes = 0;
    if (c.isNotEmpty) {
      for (var member in c) {
        if (member.toString() == '(') opens++;
        if (member.toString() == ')') closes++;
      }
      while (opens > closes) {
        c.add(bracketClose);
        closes++;
      }
      while (closes > opens) {
        for (var i = c.length - 1; i > 0; i--) {
          if (c[i].toString() == ')') {
            c.removeAt(i);
            break;
          }
        }
        closes--;
      }
    }
  }

  /// to avoid errors, return either 0 or 1 to complete an operation
  int _extraNumber(CalcButton cb) {
    return ['INV', 'ln', 'log', 'e', '√', 'x', '/'].contains(cb.text) ? 1 : 0;
  }

  /// Recursively solve the current display's contents
  num _solver(List<dynamic> c) {
    if (c.isNotEmpty) {
      num hold = 0;
      bool hasSetHold = false;
      for (var i = 0; i < c.length; i++) {
        if (c[i] is num) {
          hold = c[i];
          hasSetHold = true;
          if (i == c.length - 1) return hold;
        } else if (c[i].type == ButtonType.operatorWait) {
          if (['(', ')'].contains(c[i].text)) {
            if (i < c.length - 1) {
              return (hasSetHold ? hold : 1) * _solver(c.sublist(i + 1));
            } else {
              return hold;
            }
          } else {
            num next;
            if (i < c.length - 2) {
              next = _solver(c.sublist(i + 1));
            } else {
              if (i == c.length - 2 && c[i + 1] is num) {
                next = c[i + 1];
              } else {
                next = _extraNumber(c[i]);
              }
            }
            return c[i].math(hasSetHold ? hold : _extraNumber(c[i]), next);
          }
        } else if (c[i].type == ButtonType.operatorExecute) {
          num next;
          if (!hasSetHold) {
            if (i < c.length - 1) {
              next = _solver(c.sublist(i + 1));
            } else {
              next = _extraNumber(c[i]);
            }
          } else {
            next = hold;
          }
          return c[i].math(next);
        }
      }
      return 0;
    } else {
      return 0;
    }
  }

  void _calculate() {
    var c = _calculation.value;
    if (c.isNotEmpty) {
      if (c.length == 1) {
        _result.value = c[0] is String ? c[0] : '0';
      } else {
        _reconcileBrackets();
        c.asMap().entries.forEach((e) {
          // make all numbers in string form to be numbers for solving
          if (e.value is String) c[e.key] = num.parse(e.value);
        });
        _result.value = _solver(c).toString();
      }
    }
  }

  void updateDisplay(CalcButton calcButton) {
    switch (calcButton.type) {
      case ButtonType.degRad:
        _degRad.value = _degRad.value == DegRad.DEG ? DegRad.RAD : DegRad.DEG;
        break;
      case ButtonType.delete:
        if (_result.value != '') {
          _calculation.value = [];
          _result.value = '';
        }
        var c = _calculation.value;
        if (c.isNotEmpty) {
          if (c.last.toString().length == 1) {
            c.removeLast();
          } else {
            c.last = c.last.substring(0, c.last.length - 1);
          }
        }
        break;
      case ButtonType.equals:
        if (_result.value == '') _calculate();
        break;
      case ButtonType.operatorExecute:
        if (_result.value != '') {
          _calculation.value = [_result.value.toString()];
          _result.value = '';
        }
        var c = _calculation.value;
        if (c.isEmpty) {
          c.add(calcButton);
          c.add(bracketOpen);
        } else {
          if (c.length > 1) {
            c.insert(0, bracketOpen);
            c.add(bracketClose);
          }
          if (['!', '%'].contains(calcButton.text)) {
            c.add(calcButton);
          } else {
            c.insert(0, calcButton);
          }
          _calculate();
        }
        break;
      case ButtonType.operatorWait:
        if (_result.value != '') {
          _calculation.value = [
            if (num.parse(_result.value) != 0) _result.value.toString()
          ];
          _result.value = '';
        }
        var c = _calculation.value;
        var t = calcButton.text;
        if (c.isNotEmpty) {
          if (waitOperatorTexts.contains(c.last.toString()) &&
              // allow chaining of open or close brackets
              !(([t, c.last.toString()].contains('(') ||
                  [t, c.last.toString()].contains(')')))) {
            c.removeLast();
          }
          c.add(calcButton);
        } else if (t == '(') {
          // permit only the addition of brackets to empty screen
          c.add(calcButton);
        }
        break;
      case ButtonType.number:
        if (_result.value != '') {
          _calculation.value = [''];
          _result.value = '';
        }
        var c = _calculation.value;
        if (c.isNotEmpty && c.last is String) {
          c.last += calcButton.text;
        } else {
          c.add(calcButton.text);
        }
        break;
    }
    notifyListeners();
  }
}
