enum ErrorCode {
  invalidExpression,
  divisionByZero,
  overflow,
  underflow,
  invalidOperation,
  syntaxError
}

class CalculatorError {
  final ErrorCode code;
  final String message;

  CalculatorError({
    required this.code,
    required this.message,
  });

  @override
  String toString() => message;
}
