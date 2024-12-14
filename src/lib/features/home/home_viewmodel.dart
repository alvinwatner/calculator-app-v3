import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../services/calculator_service.dart';

class HomeViewModel extends BaseViewModel {
  final _calculatorService = locator<CalculatorService>();

  String get expression => _calculatorService.expression;
  String get result => _calculatorService.result;
  String get errorMessage => _calculatorService.error;

  void handleKeyPress(String key) {
    switch (key) {
      case '=':
        calculate();
        break;
      case 'AC':
        clearAll();
        break;
      case 'DEL':
        delete();
        break;
      default:
        _calculatorService.appendToExpression(key);
    }
  }

  void calculate() {
    _calculatorService.calculate();
  }

  void clearAll() {
    _calculatorService.clearAll();
  }

  void delete() {
    _calculatorService.deleteLast();
  }
}
