import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/deg_rad_button.dart';
import 'deg_rad_button_viewmodel.dart';

class DegRadButtonView extends StatelessWidget {
  const DegRadButtonView(this.degRadButton, {Key? key, this.color, this.height})
      : super(key: key);

  final DegRadButton degRadButton;
  final Color? color;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DegRadButtonViewModel>.reactive(
      viewModelBuilder: () => DegRadButtonViewModel(),
      builder: (context, model, child) => GestureDetector(
        child: Container(
          child: Center(
            child: Text(
              model.current,
              style: const TextStyle(fontSize: 20),
            ),
          ),
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
        onTap: () => model.pressed(),
      ),
    );
  }
}
