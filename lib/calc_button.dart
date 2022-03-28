import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  const CalcButton(this.text, {Key? key, this.color, this.height})
      : super(key: key);

  final Color? color;
  final double? height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      onTap: () {},
    );
  }
}

