import 'dart:math' as math;
import '../models/calculator_error.dart';

class ExpressionEvaluator {
  double evaluate(String expression) {
    if (expression.isEmpty) return 0;

    try {
      // Replace scientific functions and handle negative numbers
      expression = _replaceScientificFunctions(expression);

      // Replace operators
      expression = expression.replaceAll('\u00d7', '*');
      expression = expression.replaceAll('\u00f7', '/');
      expression = expression.replaceAll('^', '**');

      // Evaluate the expression
      return _evaluateExpression(expression);
    } catch (e) {
      throw CalculatorError(
        code: ErrorCode.invalidExpression,
        message: 'Invalid expression',
      );
    }
  }

  String _replaceScientificFunctions(String expression) {
    // Handle nested functions
    while (expression.contains('sin(') ||
        expression.contains('cos(') ||
        expression.contains('tan(')) {
      expression = expression.replaceAllMapped(RegExp(r'sin\(([-0-9.]+)\)'),
          (match) => math.sin(double.parse(match.group(1)!)).toString());

      expression = expression.replaceAllMapped(RegExp(r'cos\(([-0-9.]+)\)'),
          (match) => math.cos(double.parse(match.group(1)!)).toString());

      expression = expression.replaceAllMapped(RegExp(r'tan\(([-0-9.]+)\)'),
          (match) => math.tan(double.parse(match.group(1)!)).toString());
    }
    return expression;
  }

  double _evaluateExpression(String expression) {
    // Handle parentheses first
    while (expression.contains('(')) {
      final openIndex = expression.lastIndexOf('(');
      final closeIndex = expression.indexOf(')', openIndex);
      if (closeIndex == -1) {
        throw CalculatorError(
          code: ErrorCode.syntaxError,
          message: 'Mismatched parentheses',
        );
      }

      final subExpr = expression.substring(openIndex + 1, closeIndex);
      final result = _evaluateExpression(subExpr);
      expression = expression.substring(0, openIndex) +
          result.toString() +
          expression.substring(closeIndex + 1);
    }

    // Evaluate exponents
    while (expression.contains('**')) {
      final regex = RegExp(r'([-+]?\d*\.?\d+)\*\*([-+]?\d*\.?\d+)');
      final match = regex.firstMatch(expression);
      if (match == null) break;

      final base = double.parse(match.group(1)!);
      final exponent = double.parse(match.group(2)!);
      final result = math.pow(base, exponent);

      expression =
          expression.replaceFirst(regex, result.toString(), match.start);
    }

    // Evaluate multiplication and division
    while (expression.contains('*') || expression.contains('/')) {
      final regex = RegExp(r'([-+]?\d*\.?\d+)[*/]([-+]?\d*\.?\d+)');
      final match = regex.firstMatch(expression);
      if (match == null) break;

      final a = double.parse(match.group(1)!);
      final b = double.parse(match.group(2)!);
      final op = expression[match.start + match.group(1)!.length];

      double result;
      if (op == '*') {
        result = a * b;
      } else {
        if (b == 0) {
          throw CalculatorError(
            code: ErrorCode.divisionByZero,
            message: 'Division by zero',
          );
        }
        result = a / b;
      }

      expression =
          expression.replaceFirst(regex, result.toString(), match.start);
    }

    // Evaluate addition and subtraction
    List<String> parts = expression.split(RegExp(r'(?=[-+])'));
    double result = double.parse(parts[0]);
    for (int i = 1; i < parts.length; i++) {
      String part = parts[i];
      if (part.startsWith('+')) {
        result += double.parse(part.substring(1));
      } else if (part.startsWith('-')) {
        result -= double.parse(part.substring(1));
      }
    }

    return result;
  }
}
