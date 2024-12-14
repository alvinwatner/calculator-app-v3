import 'package:flutter/material.dart';

class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;
  final String error;

  const CalculatorDisplay({
    Key? key,
    required this.expression,
    required this.result,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.bottomRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            expression,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.grey,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            error.isNotEmpty ? error : result,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: error.isNotEmpty ? Colors.red : Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
