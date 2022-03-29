import 'dart:math';

import '../app/locator.dart';
import '../services/display.service.dart';
import 'button_type.dart';

class CalcButton {
  String text;
  final ButtonType type;
  final Function? math;

  CalcButton(this.text, this.type, [this.math]);

  @override
  toString() => text;
}

const baseWaitOperatorTexts = ['/', 'x', '-', '+'];
final bracketClose = CalcButton(')', ButtonType.operatorWait);
final bracketOpen = CalcButton('(', ButtonType.operatorWait);
const waitOperatorTexts = [...baseWaitOperatorTexts, '^', '(', ')'];

final baseWaitOperators = [
  CalcButton('/', ButtonType.operatorWait, (x, y) => x / y),
  CalcButton('x', ButtonType.operatorWait, (x, y) => x * y),
  CalcButton('-', ButtonType.operatorWait, (x, y) => x - y),
  CalcButton('+', ButtonType.operatorWait, (x, y) => x + y),
];

final _displayService = locator<DisplayService>();

int _factorial(int x) => x == 0 || x == 1 ? 1 : x * _factorial(x - 1);

final moreOperators = [
  [
    CalcButton('INV', ButtonType.operatorExecute, (n) => 1 / n),
    // degrad display value is set in CalcButtonView based on ViewModel
    CalcButton('', ButtonType.degRad),
    CalcButton(
        'sin',
        ButtonType.operatorExecute,
        (n) => _displayService.degRad == DegRad.RAD
            ? sin(n)
            : sin((n * pi) / 180)),
    CalcButton(
        'cos',
        ButtonType.operatorExecute,
        (n) => _displayService.degRad == DegRad.RAD
            ? cos(n)
            : cos((n * pi) / 180)),
    CalcButton(
        'tan',
        ButtonType.operatorExecute,
        (n) => _displayService.degRad == DegRad.RAD
            ? tan(n)
            : tan((n * pi) / 180)),
  ],
  [
    CalcButton('%', ButtonType.operatorExecute, (n) => n / 100),
    CalcButton('ln', ButtonType.operatorExecute, log),
    CalcButton('log', ButtonType.operatorExecute, (n) => ln10 * log(n)),
    CalcButton(
      '!',
      ButtonType.operatorExecute,
      (n) => _factorial(double.parse(n).truncate()),
    ),
    CalcButton('^', ButtonType.operatorWait, pow),
  ],
  [
    CalcButton(
        'sin',
        ButtonType.operatorExecute,
        (n) => _displayService.degRad == DegRad.RAD
            ? sin(n)
            : sin((n * pi) / 180)),
    CalcButton('e', ButtonType.operatorExecute, exp),
    bracketOpen,
    bracketClose,
    CalcButton('√', ButtonType.operatorExecute, sqrt),
  ]
];
