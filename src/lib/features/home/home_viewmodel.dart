import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../services/calculator_service.dart';

class HomeViewModel extends BaseViewModel {
  final _calculatorService = locator<CalculatorService>();

  String get expression => _calculatorService.expression;
  String get result => _calculatorService.result;
  String get error => _calculatorService.error;

  void handleKeyPress(String key) {
    _calculatorService.appendToExpression(key);
  }

  void clearAll() {
    _calculatorService.clearAll();
  }

  void delete() {
    _calculatorService.deleteLast();
  }

  void calculate() {
    _calculatorService.calculate();
  }
}
