import 'package:stacked/stacked.dart';
import '../models/calculation_result.dart';
import '../models/calculator_error.dart';
import '../utils/calculator_functions.dart';
import '../utils/number_formatter.dart';
import '../utils/validation_utils.dart';

class CalculatorService with ListenableServiceMixin {
  String _expression = '';
  String _result = '0';
  String _error = '';
  double? _lastResult;
  bool _shouldClearOnNextInput = false;

  String get expression => _expression;
  String get result => _result;
  String get error => _error;

  void appendToExpression(String value) {
    if (_shouldClearOnNextInput) {
      _expression = '';
      _shouldClearOnNextInput = false;
    }

    _error = '';
    if (_lastResult != null && _expression.isEmpty && !_isOperator(value)) {
      _lastResult = null;
    }
    _expression += value;
    notifyListeners();
  }

  void clearAll() {
    _expression = '';
    _result = '0';
    _error = '';
    _lastResult = null;
    _shouldClearOnNextInput = false;
    notifyListeners();
  }

  void deleteLast() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  bool _isOperator(String value) {
    return ['+', '-', '\u00d7', '\u00f7', '^'].contains(value);
  }

  void calculate() {
    if (_expression.isEmpty) {
      if (_lastResult != null) {
        _result = NumberFormatter.format(_lastResult!);
        return;
      }
      return;
    }

    if (!ValidationUtils.isCompleteExpression(_expression)) {
      _error = 'Invalid expression';
      notifyListeners();
      return;
    }

    try {
      final evaluator = ExpressionEvaluator();
      final workingExpression =
          _lastResult != null && _isOperator(_expression[0])
              ? '${_lastResult!}${_expression}'
              : _expression;

      final result = evaluator.evaluate(workingExpression);

      // Validate result
      final validationError = ValidationUtils.validateNumber(result);
      if (validationError != null) {
        _error = validationError.message;
        _result = '0';
        _lastResult = null;
      } else {
        _result = NumberFormatter.format(result);
        _lastResult = result;
        _shouldClearOnNextInput = true;
      }
    } catch (e) {
      _error = e.toString();
      _result = '0';
      _lastResult = null;
    }

    notifyListeners();
  }
}
