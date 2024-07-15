import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'history_viewmodel.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.nonReactive(
      viewModelBuilder: () => HistoryViewModel(),
      builder: (context, model, _) => Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: model.current
                  .toList()
                  .asMap()
                  .entries
                  .map(
                    (entry) => [
                      Text(
                        entry.value.display.map((e) => e.toString()).join(' '),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        entry.value.result,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.black),
                      ),
                      if (entry.key < model.current.length - 1) ...[
                        const SizedBox(height: 16),
                        const Divider(thickness: 2),
                        const SizedBox(height: 16),
                      ]
                    ],
                  )
                  .expand((w) => w)
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
