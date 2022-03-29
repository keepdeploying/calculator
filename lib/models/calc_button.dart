import 'dart:math';

import '../app/locator.dart';
import '../services/deg_rad.service.dart';
import 'button_type.dart';
import 'deg_rad_button.dart';

class CalcButton {
  final String text;
  final ButtonType type;
  final Function? math;

  const CalcButton(this.text, this.type, [this.math]);

  @override
  toString() => text;
}

const baseWaitOperatorTexts = ['/', 'x', '-', '+'];
const bracketClose = CalcButton(')', ButtonType.operatorWait);
const bracketOpen = CalcButton('(', ButtonType.operatorWait);
const waitOperatorTexts = [...baseWaitOperatorTexts, '^', '(', ')'];

final baseWaitOperators = [
  CalcButton('/', ButtonType.operatorWait, (x, y) => x / y),
  CalcButton('x', ButtonType.operatorWait, (x, y) => x * y),
  CalcButton('-', ButtonType.operatorWait, (x, y) => x - y),
  CalcButton('+', ButtonType.operatorWait, (x, y) => x + y),
];

final _degRadService = locator<DegRadService>();

int _factorial(int x) => x == 0 || x == 1 ? 1 : x * _factorial(x - 1);

final moreOperators = [
  [
    CalcButton('INV', ButtonType.operatorExecute, (n) => 1 / n),
    DegRadButton(),
    CalcButton(
        'sin',
        ButtonType.operatorExecute,
        (n) => _degRadService.current == DegRad.RAD
            ? sin(n)
            : sin((n * pi) / 180)),
    CalcButton(
        'cos',
        ButtonType.operatorExecute,
        (n) => _degRadService.current == DegRad.RAD
            ? cos(n)
            : cos((n * pi) / 180)),
    CalcButton(
        'tan',
        ButtonType.operatorExecute,
        (n) => _degRadService.current == DegRad.RAD
            ? tan(n)
            : tan((n * pi) / 180)),
  ],
  [
    CalcButton('%', ButtonType.operatorExecute, (n) => n / 100),
    const CalcButton('ln', ButtonType.operatorExecute, log),
    CalcButton('log', ButtonType.operatorExecute, (n) => ln10 * log(n)),
    CalcButton(
      '!',
      ButtonType.operatorExecute,
      (n) => _factorial(n.truncate()),
    ),
    const CalcButton('^', ButtonType.operatorWait, pow),
  ],
  [
    CalcButton(
        'sin',
        ButtonType.operatorExecute,
        (n) => _degRadService.current == DegRad.RAD
            ? sin(n)
            : sin((n * pi) / 180)),
    const CalcButton('e', ButtonType.operatorExecute, exp),
    bracketOpen,
    bracketClose,
    const CalcButton('√', ButtonType.operatorExecute, sqrt),
  ]
];
