import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'deg_rad_state_viewmodel.dart';

class DegRadStateView extends StatelessWidget {
  const DegRadStateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DegRadStateViewModel>.reactive(
      viewModelBuilder: () => DegRadStateViewModel(),
      builder: (context, model, child) => Text(
        model.current,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
