import 'package:flutter/material.dart';

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
    final _w = MediaQuery.of(context).size.width;

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
                        children: row
                            .map(
                              (text) => GestureDetector(
                                child: Container(
                                  child: Center(child: Text(text)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(1, 1),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 8,
                                  ),
                                  width: (_w - 96) / 5,
                                ),
                                onTap: () {},
                              ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: row
                                  .map(
                                    (text) => Opacity(
                                      opacity: text == '' ? 0 : 1,
                                      child: GestureDetector(
                                        child: Container(
                                          child: Center(child: Text(text)),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                                spreadRadius: 0.5,
                                              ),
                                            ],
                                            color: Colors.white,
                                          ),
                                          height: ((_h * 0.4) - 72) / 4,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 8,
                                          ),
                                          width: (_w - 96) / 5,
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                          .toList(),
                    ),
                    width: _w * 0.6,
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
                                (text) => GestureDetector(
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
                                      color: Colors.white,
                                    ),
                                    height: ((_h * 0.4) - 72) / 4,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    width: (_w - 96) / 5,
                                  ),
                                  onTap: () {},
                                ),
                              )
                              .toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: ['DEL', '=']
                              .map(
                                (text) => GestureDetector(
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
                                      color: text == '='
                                          ? Colors.green
                                          : Colors.white,
                                    ),
                                    height: text == '='
                                        ? 24 + (((_h * 0.4) - 72) / 4) * 3
                                        : ((_h * 0.4) - 72) / 4,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    width: (_w - 96) / 5,
                                  ),
                                  onTap: () {},
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                    width: _w * 0.4,
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
