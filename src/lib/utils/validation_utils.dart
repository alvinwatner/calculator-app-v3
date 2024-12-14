import '../models/calculator_error.dart';
import '../utils/constants.dart';

class ValidationUtils {
  static bool isValidExpression(String expression) {
    if (expression.isEmpty) return false;

    // Check for balanced parentheses
    int parenthesesCount = 0;
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '(') parenthesesCount++;
      if (expression[i] == ')') parenthesesCount--;
      if (parenthesesCount < 0) return false;
    }
    if (parenthesesCount != 0) return false;

    // Check for consecutive operators
    for (int i = 0; i < expression.length - 1; i++) {
      if (_isOperator(expression[i]) && _isOperator(expression[i + 1])) {
        return false;
      }
    }

    // Check if expression ends with an operator
    if (_isOperator(expression[expression.length - 1])) {
      return false;
    }

    return true;
  }

  static bool _isOperator(String char) {
    return CalculatorConstants.basicOperators.contains(char);
  }

  static CalculatorError? validateNumber(double number) {
    if (number.isInfinite) {
      return CalculatorError(
        code: ErrorCode.overflow,
        message: 'Result too large',
      );
    }
    if (number.isNaN) {
      return CalculatorError(
        code: ErrorCode.invalidOperation,
        message: 'Invalid operation',
      );
    }
    if (number.abs() > 1e100) {
      return CalculatorError(
        code: ErrorCode.overflow,
        message: 'Number exceeds maximum limit',
      );
    }
    if (number != 0 && number.abs() < 1e-100) {
      return CalculatorError(
        code: ErrorCode.underflow,
        message: 'Number below minimum limit',
      );
    }
    return null;
  }

  static bool isCompleteExpression(String expression) {
    if (expression.isEmpty) return false;

    // Check for incomplete scientific functions
    for (String func in CalculatorConstants.scientificOperators) {
      if (expression.endsWith(func)) return false;
      if (expression.contains('$func(') &&
          !expression.contains('$func(-)') &&
          !RegExp(r'\$func\([0-9.]+\)').hasMatch(expression)) {
        return false;
      }
    }

    return isValidExpression(expression);
  }
}
