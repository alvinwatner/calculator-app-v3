import 'package:flutter/material.dart';
import '../../../ui/common/app_colors.dart';

class ScientificKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onClear;
  final VoidCallback onDelete;
  final VoidCallback onCalculate;

  const ScientificKeypad({
    Key? key,
    required this.onKeyPressed,
    required this.onClear,
    required this.onDelete,
    required this.onCalculate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [
          _buildButton('sin', color: kcMediumGrey),
          _buildButton('cos', color: kcMediumGrey),
          _buildButton('tan', color: kcMediumGrey),
          _buildButton('DEL', color: kcPrimaryColor, onPressed: onDelete),
          _buildButton('(', color: kcMediumGrey),
          _buildButton(')', color: kcMediumGrey),
          _buildButton('^', color: kcMediumGrey),
          _buildButton('AC', color: kcPrimaryColor, onPressed: onClear),
          _buildButton('7'),
          _buildButton('8'),
          _buildButton('9'),
          _buildButton('÷', color: kcMediumGrey),
          _buildButton('4'),
          _buildButton('5'),
          _buildButton('6'),
          _buildButton('×', color: kcMediumGrey),
          _buildButton('1'),
          _buildButton('2'),
          _buildButton('3'),
          _buildButton('-', color: kcMediumGrey),
          _buildButton('.'),
          _buildButton('0'),
          _buildButton('=', color: kcPrimaryColorDark, onPressed: onCalculate),
          _buildButton('+', color: kcMediumGrey),
        ],
      ),
    );
  }

  Widget _buildButton(String text, {Color? color, VoidCallback? onPressed}) {
    return Material(
      color: color ?? kcDarkGreyColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed ?? () => onKeyPressed(text),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
