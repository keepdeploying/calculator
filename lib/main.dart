import 'package:flutter/material.dart';
import 'calc_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _h = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'DEG',
                        style: TextStyle(
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
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.35,
              padding: const EdgeInsets.all(16),
            ),
            Container(
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ['INV', 'RAD', 'sin', 'cos', 'tan'],
                  ['%', 'ln', 'log', '!', '^'],
                  ['sin', 'e', '(', ')', 's']
                ]
                    .map(
                      (row) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: row.map((text) => CalcButton(text)).toList(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: row
                                  .map(
                                    (text) => Opacity(
                                      opacity: text == '' ? 0 : 1,
                                      child: CalcButton(
                                        text,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: ['/', 'x', '-', '+']
                              .map(
                                (text) => CalcButton(
                                  text,
                                  height: ((_h * 0.4) - 72) / 4,
                                ),
                              )
                              .toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CalcButton(
                              'DEL',
                              height: ((_h * 0.4) - 72) / 4,
                            ),
                            CalcButton(
                              '=',
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
  }
}
