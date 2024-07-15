import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'display_viewmodel.dart';

class DisplayView extends StatelessWidget {
  const DisplayView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DisplayViewModel>.reactive(
      viewModelBuilder: () => DisplayViewModel(),
      builder: (context, model, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            model.current,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (model.result != '')
            Text(
              model.result,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.black),
            ),
        ],
      ),
    );
  }
}
