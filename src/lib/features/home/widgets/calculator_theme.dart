import 'package:flutter/material.dart';
import '../../../ui/common/app_colors.dart';

class CalculatorTheme {
  static ThemeData darkPurpleTheme = ThemeData(
    scaffoldBackgroundColor: kcBackgroundColor,
    brightness: Brightness.dark,
    primaryColor: kcPrimaryColor,
    colorScheme: const ColorScheme.dark(
      primary: kcPrimaryColor,
      secondary: kcPrimaryColorDark,
      surface: kcDarkGreyColor,
      background: kcBackgroundColor,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontFamily: 'monospace',
      ),
      bodyMedium: TextStyle(
        color: kcLightGrey,
        fontSize: 18,
        fontFamily: 'monospace',
      ),
    ),
    cardTheme: CardTheme(
      color: kcDarkGreyColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: kcMediumGrey,
      thickness: 1,
      space: 1,
    ),
  );
}
