import 'dart:math' as math;
import 'package:stacked/stacked.dart';
import '../utils/calculator_functions.dart';

class CalculatorService with ListenableServiceMixin {
  String _expression = '';
  String _result = '0';
  String _error = '';

  String get expression => _expression;
  String get result => _result;
  String get error => _error;

  void appendToExpression(String value) {
    _error = '';
    _expression += value;
    notifyListeners();
  }

  void clearAll() {
    _expression = '';
    _result = '0';
    _error = '';
    notifyListeners();
  }

  void deleteLast() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void calculate() {
    try {
      _error = '';
      final evaluator = ExpressionEvaluator();
      final result = evaluator.evaluate(_expression);
      _result = formatResult(result);
    } catch (e) {
      _error = 'Error';
    }
    notifyListeners();
  }

  String formatResult(double result) {
    if (result == result.roundToDouble()) {
      return result.toInt().toString();
    }
    return result
        .toStringAsFixed(8)
        .replaceAll(RegExp(r'0*$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }
}
