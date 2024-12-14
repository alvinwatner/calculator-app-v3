import 'calculator_error.dart';

class CalculationResult {
  final double? value;
  final CalculatorError? error;
  final String formattedValue;
  final bool isScientificNotation;

  CalculationResult({
    this.value,
    this.error,
    required this.formattedValue,
    this.isScientificNotation = false,
  });

  bool get hasError => error != null;
  bool get hasValue => value != null;

  factory CalculationResult.error(CalculatorError error) {
    return CalculationResult(
      error: error,
      formattedValue: error.message,
    );
  }

  factory CalculationResult.value(
    double value,
    String formattedValue, {
    bool isScientificNotation = false,
  }) {
    return CalculationResult(
      value: value,
      formattedValue: formattedValue,
      isScientificNotation: isScientificNotation,
    );
  }
}
