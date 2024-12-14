class NumberFormatter {
  static String format(double value, {int maxDecimalPlaces = 10}) {
    if (value.abs() >= 1e10 || (value != 0 && value.abs() < 1e-10)) {
      return _formatScientific(value, maxDecimalPlaces);
    }

    String result = value.toStringAsFixed(maxDecimalPlaces);

    // Remove trailing zeros after decimal point
    if (result.contains('.')) {
      result = result.replaceAll(RegExp(r'0*$'), '');
      if (result.endsWith('.')) {
        result = result.substring(0, result.length - 1);
      }
    }

    return result;
  }

  static String _formatScientific(double value, int maxDecimalPlaces) {
    String exponential = value.toStringAsExponential(maxDecimalPlaces - 1);

    // Format the mantissa and exponent
    List<String> parts = exponential.split('e');
    double mantissa = double.parse(parts[0]);
    int exponent = int.parse(parts[1]);

    // Remove trailing zeros from mantissa
    String formattedMantissa = mantissa.toString();
    if (formattedMantissa.contains('.')) {
      formattedMantissa = formattedMantissa.replaceAll(RegExp(r'0*$'), '');
      if (formattedMantissa.endsWith('.')) {
        formattedMantissa =
            formattedMantissa.substring(0, formattedMantissa.length - 1);
      }
    }

    return '${formattedMantissa}e$exponent';
  }
}
