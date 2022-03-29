import 'package:calculator/models/calc_button.dart';
import 'package:calculator/ui/views/calculator/calculator_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/button_type.dart';
import '../calc_button/calc_button_view.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalculatorViewModel>.reactive(
        viewModelBuilder: () => CalculatorViewModel(),
        builder: (context, model, child) {
          final _h = MediaQuery.of(context).size.height;
          final screenWidth = MediaQuery.of(context).size.width;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.degRad.toString().split('.')[1],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PopupMenuButton(
                              itemBuilder: (context) => const [
                                PopupMenuItem(child: Text('History')),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              model.current,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            if (model.result != '')
                              Text(
                                model.result,
                                style: Theme.of(context).textTheme.headline3,
                              ),
                          ],
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.35,
                    padding: const EdgeInsets.all(16),
                  ),
                  Container(
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: moreOperators
                          .map(
                            (row) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children:
                                  row.map((cb) => CalcButtonView(cb)).toList(),
                            ),
                          )
                          .toList(),
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ['7', '8', '9'],
                              ['4', '5', '6'],
                              ['1', '2', '3'],
                              ['.', '0', ''],
                            ]
                                .map(
                                  (row) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: row
                                        .map(
                                          (text) => Opacity(
                                            opacity: text == '' ? 0 : 1,
                                            child: CalcButtonView(
                                              CalcButton(
                                                text,
                                                ButtonType.number,
                                              ),
                                              height: ((_h * 0.4) - 72) / 4,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                                .toList(),
                          ),
                          width: screenWidth * 0.6,
                        ),
                        Container(
                          color: Colors.grey[400],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: baseWaitOperatorTexts
                                    .map(
                                      (text) => CalcButtonView(
                                        CalcButton(
                                          text,
                                          ButtonType.operatorWait,
                                        ),
                                        height: ((_h * 0.4) - 72) / 4,
                                      ),
                                    )
                                    .toList(),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CalcButtonView(
                                    CalcButton('DEL', ButtonType.delete),
                                    height: ((_h * 0.4) - 72) / 4,
                                  ),
                                  CalcButtonView(
                                    CalcButton('=', ButtonType.equals),
                                    color: Colors.green,
                                    height: 24 + (((_h * 0.4) - 72) / 4) * 3,
                                  )
                                ],
                              ),
                            ],
                          ),
                          width: screenWidth * 0.4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
