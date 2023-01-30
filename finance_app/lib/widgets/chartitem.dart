import 'package:flutter/material.dart';

class ChartItem extends StatelessWidget {
  final String amount;
  final String day;

  const ChartItem({super.key, required this.amount, required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.all(5),
          child: Text(
            "\$ : $amount",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
