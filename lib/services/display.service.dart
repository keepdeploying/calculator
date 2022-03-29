import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../models/button_type.dart';
import '../models/calc_button.dart';

// ignore: constant_identifier_names
enum DegRad { DEG, RAD }

@singleton
class DisplayService with ReactiveServiceMixin {
  final _calculation = ReactiveValue<List<dynamic>>([]);
  final _degRad = ReactiveValue<DegRad>(DegRad.DEG);
  final _result = ReactiveValue<String>('');
  String get current => _calculation.value.map((e) => e.toString()).join(' ');
  DegRad get degRad => _degRad.value;
  String get result => _result.value;

  DisplayService() {
    listenToReactiveValues([_calculation, _result]);
  }

  void _calculate() {
    var c = _calculation.value;
    if (c.isNotEmpty) {
      if (c.length == 1) {
        _result.value = c[0] is String ? c[0] : '0';
      } else {
        _reconcileBrackets();
        // TODO: Solve with operators and their math functions
        _result.value = _calculation.value.map((e) => e.toString()).join(' ');
      }
      _calculation.value = [];
    }
  }

  void _reconcileBrackets() {
    var c = _calculation.value;
    if (c.isNotEmpty) {
      // TODO: Implement reconcile brackets
    }
  }

  void updateDisplay(CalcButton calcButton) {
    switch (calcButton.type) {
      case ButtonType.degRad:
        _degRad.value = _degRad.value == DegRad.DEG ? DegRad.RAD : DegRad.DEG;
        break;
      case ButtonType.delete:
        var c = _calculation.value;
        if (c.isNotEmpty) {
          if (c.last.toString().length == 1) {
            c.removeLast();
          } else {
            c.last = c.last.substring(0, c.last.length - 1);
          }
        }
        _result.value = '';
        break;
      case ButtonType.equals:
        _calculate();
        break;
      case ButtonType.operatorExecute:
        _result.value = '';
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
        _result.value = '';
        var c = _calculation.value;
        var l = c.last.toString();
        var t = calcButton.text;
        // remove the last added _calculation member if it was an operator
        // did this to reduce user mistake
        if ((c.isNotEmpty && waitOperatorTexts.contains(l))) {
          // allow chaining of open or close brackets
          if (!(((['('].contains(t) && ['('].contains(l)) ||
              ([')'].contains(t) && [')'].contains(l))))) {
            c.removeLast();
          }
        }
        c.add(calcButton);
        break;
      case ButtonType.number:
        _result.value = '';
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
