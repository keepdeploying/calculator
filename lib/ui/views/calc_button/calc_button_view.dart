import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/button_type.dart';
import '../../../models/calc_button.dart';
import 'calc_button_viewmodel.dart';

class CalcButtonView extends StatelessWidget {
  const CalcButtonView(this.calcButton, {Key? key, this.color, this.height})
      : super(key: key);

  final CalcButton calcButton;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalcButtonViewModel>.reactive(
      viewModelBuilder: () => CalcButtonViewModel(),
      builder: (context, model, child) {
        if (calcButton.type == ButtonType.degRad) {
          calcButton.text = model.degRad;
        }

        return GestureDetector(
          child: Container(
            child: Center(child: Text(calcButton.text)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                  spreadRadius: 0.5,
                ),
              ],
              color: color ?? Colors.white,
            ),
            height: height,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            width: (MediaQuery.of(context).size.width - 96) / 5,
          ),
          onTap: () => model.pressed(calcButton),
        );
      },
    );
  }
}
