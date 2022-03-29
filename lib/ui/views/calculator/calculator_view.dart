import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/button_type.dart';
import '../../../models/calc_button.dart';
import '../../../models/deg_rad_button.dart';
import '../calc_button/calc_button_view.dart';
import '../deg_rad_button/deg_rad_button_view.dart';
import '../deg_rad_state/deg_rad_state_view.dart';
import '../display/display_view.dart';
import '../history/history_view.dart';
import 'calculator_viewmodel.dart';

const kGreenColor = Color(0xFF72A376);

class CalculatorView extends StatelessWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CalculatorViewModel>.nonReactive(
        viewModelBuilder: () => CalculatorViewModel(),
        builder: (context, model, _) {
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
                            const DegRadStateView(),
                            IconButton(
                              icon: const Icon(Icons.history),
                              onPressed: () {
                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  transitionDuration:
                                      const Duration(milliseconds: 500),
                                  barrierLabel:
                                      MaterialLocalizations.of(context)
                                          .dialogLabel,
                                  pageBuilder: (context, _, __) =>
                                      const HistoryView(),
                                  transitionBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return SlideTransition(
                                      position: CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOut,
                                      ).drive(Tween<Offset>(
                                        begin: const Offset(0, -1.0),
                                        end: Offset.zero,
                                      )),
                                      child: child,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const DisplayView(),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.35,
                    padding: const EdgeInsets.all(16),
                  ),
                  Container(
                    color: kGreenColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: moreOperators
                          .map(
                            (row) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: row
                                  .map(
                                    (cb) => cb is DegRadButton
                                        ? DegRadButtonView(cb)
                                        : CalcButtonView(cb),
                                  )
                                  .toList(),
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
                          color: const Color(0xFFF1F1F1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: baseWaitOperators
                                    .map(
                                      (cb) => CalcButtonView(
                                        cb,
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
                                    const CalcButton('DEL', ButtonType.delete),
                                    height: ((_h * 0.4) - 72) / 4,
                                  ),
                                  CalcButtonView(
                                    const CalcButton('=', ButtonType.equals),
                                    color: kGreenColor,
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
