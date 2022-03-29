import 'dart:math';

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

num _factorial(num x) => x == 0 || x == 1 ? 1 : x * _factorial(x - 1);

final moreOperators = [
  [
    CalcButton('INV', ButtonType.operatorExecute, (n) => 1 / n),
    // its display value is set in CalcButtonView based on ViewModel
    CalcButton('', ButtonType.degRad),
    CalcButton('sin', ButtonType.operatorExecute, sin),
    CalcButton('cos', ButtonType.operatorExecute, cos),
    CalcButton('tan', ButtonType.operatorExecute, tan),
  ],
  [
    CalcButton('%', ButtonType.operatorExecute, (n) => n / 100),
    CalcButton('ln', ButtonType.operatorExecute, log),
    CalcButton('log', ButtonType.operatorExecute, (n) => ln10 * log(n)),
    CalcButton('!', ButtonType.operatorExecute, _factorial),
    CalcButton('^', ButtonType.operatorWait),
  ],
  [
    CalcButton('sin', ButtonType.operatorExecute, sin),
    CalcButton('e', ButtonType.operatorExecute, exp),
    bracketOpen,
    bracketClose,
    CalcButton('√', ButtonType.operatorExecute, sqrt),
  ]
];
