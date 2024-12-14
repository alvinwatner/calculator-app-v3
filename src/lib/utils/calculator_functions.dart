import 'dart:math' as math;

class ExpressionEvaluator {
  double evaluate(String expression) {
    if (expression.isEmpty) return 0;

    try {
      // Replace scientific functions
      expression = _replaceScientificFunctions(expression);

      // Replace operators
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      expression = expression.replaceAll('^', '**');

      // Evaluate basic arithmetic
      return _evaluateExpression(expression);
    } catch (e) {
      throw Exception('Invalid expression');
    }
  }

  String _replaceScientificFunctions(String expression) {
    expression = expression.replaceAllMapped(RegExp(r'sin\(([-0-9.]+)\)'),
        (match) => math.sin(double.parse(match.group(1)!)).toString());

    expression = expression.replaceAllMapped(RegExp(r'cos\(([-0-9.]+)\)'),
        (match) => math.cos(double.parse(match.group(1)!)).toString());

    expression = expression.replaceAllMapped(RegExp(r'tan\(([-0-9.]+)\)'),
        (match) => math.tan(double.parse(match.group(1)!)).toString());

    return expression;
  }

  double _evaluateExpression(String expression) {
    // Simple expression evaluator for basic arithmetic
    // This is a basic implementation - a more robust parser would be needed for production

    if (expression.contains('(')) {
      // Handle parentheses
      int openIndex = expression.lastIndexOf('(');
      int closeIndex = expression.indexOf(')', openIndex);
      String subExpr = expression.substring(openIndex + 1, closeIndex);
      double result = _evaluateExpression(subExpr);
      String newExpr = expression.substring(0, openIndex) +
          result.toString() +
          expression.substring(closeIndex + 1);
      return _evaluateExpression(newExpr);
    }

    // Evaluate exponents
    if (expression.contains('**')) {
      List<String> parts = expression.split('**');
      return math
          .pow(_evaluateExpression(parts[0]), _evaluateExpression(parts[1]))
          .toDouble();
    }

    // Split by addition/subtraction
    List<String> addParts = expression.split(RegExp(r'(?=[-+])'));
    if (addParts.length > 1) {
      double result = _evaluateExpression(addParts[0]);
      for (int i = 1; i < addParts.length; i++) {
        String part = addParts[i];
        if (part.startsWith('+')) {
          result += _evaluateExpression(part.substring(1));
        } else if (part.startsWith('-')) {
          result -= _evaluateExpression(part.substring(1));
        }
      }
      return result;
    }

    // Split by multiplication/division
    List<String> mulParts = expression.split(RegExp(r'[*/]'));
    if (mulParts.length > 1) {
      double result = _evaluateExpression(mulParts[0]);
      List<String> operators = expression.split(RegExp(r'[0-9.]+'))
        ..removeWhere((e) => e.isEmpty);
      for (int i = 0; i < operators.length; i++) {
        String operator = operators[i];
        double nextNum = _evaluateExpression(mulParts[i + 1]);
        if (operator == '*') {
          result *= nextNum;
        } else if (operator == '/') {
          if (nextNum == 0) throw Exception('Division by zero');
          result /= nextNum;
        }
      }
      return result;
    }

    return double.parse(expression);
  }
}
