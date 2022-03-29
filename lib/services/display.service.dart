import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';

import '../app/locator.dart';
import '../models/button_type.dart';
import '../models/calc_button.dart';
import 'calculator.service.dart';

@singleton
class DisplayService with ReactiveServiceMixin {
  /// contains either operator [CalcButton]s or numbers that as [String]s.
  final _calculation = ReactiveValue<List<dynamic>>(['']);

  final _calculator = locator<CalculatorService>();
  final _result = ReactiveValue<String>('');
  String get current => _calculation.value.map((e) => e.toString()).join(' ');
  String get result => _result.value;

  DisplayService() {
    listenToReactiveValues([_calculation, _result]);
  }
  
  void updateDisplay(CalcButton calcButton) {
    switch (calcButton.type) {
      case ButtonType.degRad:
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
        if (_result.value == '') {
          _result.value = _calculator.calculate(_calculation.value);
        }
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
          _result.value = _calculator.calculate(c);
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
          // among others waitOperators
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
