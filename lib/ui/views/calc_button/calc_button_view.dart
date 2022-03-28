import 'package:calculator/ui/views/calc_button/calc_button_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CalcButtonView extends StatelessWidget {
  const CalcButtonView(this.text, {Key? key, this.color, this.height})
      : super(key: key);

  final Color? color;
  final double? height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalcButtonViewModel>.nonReactive(
      viewModelBuilder: () => CalcButtonViewModel(),
      builder: (context, model, _) => GestureDetector(
        child: Container(
          child: Center(child: Text(text)),
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
        onTap: () => model.pressed(text),
      ),
    );
  }
}
