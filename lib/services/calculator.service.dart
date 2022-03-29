import 'package:injectable/injectable.dart';

import '../models/button_type.dart';
import '../models/calc_button.dart';

@singleton
class CalculatorService {
  /// to avoid errors, return either 0 or 1 to complete an operation
  int _extraNumber(CalcButton cb) {
    return ['INV', 'ln', 'log', 'e', '√', 'x', '/'].contains(cb.text) ? 1 : 0;
  }
  
  void _reconcileBrackets(List<dynamic> c) {
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

  /// Returns result of calculating contents of [c]. [c] should be a list 
  /// containing either numbers in [String] form, or [CalcButton]s.
  String calculate(List<dynamic> c) {
    if (c.isNotEmpty) {
      if (c.length == 1) {
        return c[0] is String ? c[0] : '0';
      } else {
        _reconcileBrackets(c);
        c.asMap().entries.forEach((e) {
          // make all numbers in string form to be numbers for solving
          if (e.value is String) c[e.key] = num.parse(e.value);
        });
        return _solver(c).toString();
      }
    } else {
      return '';
    }
  }
}
