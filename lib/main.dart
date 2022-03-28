import 'package:flutter/material.dart';

import 'app/locator.dart';
import 'ui/views/calculator/calculator_view.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorView(),
    );
  }
}
