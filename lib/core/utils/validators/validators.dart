/// Input validation utilities with extension methods for custom error messages
///
/// Usage examples:
/// ```dart
/// // Using extensions with custom messages
/// validator: (value) => value.validateRequired(message: 'Username is required'),
/// validator: (value) => value.validateEmail(message: 'Please enter a valid email'),
/// validator: (value) => value.validateMinLength(8, message: 'Password must be at least 8 characters'),
///
/// // Chaining validators
/// validator: (value) => value.validateRequired() ?? value.validateEmail(),
///
/// // Using static methods (backward compatibility)
/// validator: (value) => Validators.required(value, 'Username'),
/// ```
library;

/// Extension on String? for validation with custom messages
extension StringValidatorExtension on String? {
  /// Validate required field
  String? validateRequired({String? message}) {
    if (this == null || this!.trim().isEmpty) {
      return message ?? 'This field is required';
    }
    return null;
  }

  /// Validate email
  String? validateEmail({String? message}) {
    if (this == null || this!.isEmpty) {
      return null; // Let required validator handle empty
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(this!)) {
      return message ?? 'Enter a valid email address';
    }

    return null;
  }

  /// Validate phone number
  String? validatePhone({String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(this!)) {
      return message ?? 'Enter a valid phone number';
    }

    return null;
  }

  /// Validate URL
  String? validateUrl({String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    if (!urlRegex.hasMatch(this!)) {
      return message ?? 'Enter a valid URL';
    }

    return null;
  }

  /// Validate minimum length
  String? validateMinLength(int length, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (this!.length < length) {
      return message ?? 'Must be at least $length characters';
    }

    return null;
  }

  /// Validate maximum length
  String? validateMaxLength(int length, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (this!.length > length) {
      return message ?? 'Must not exceed $length characters';
    }

    return null;
  }

  /// Validate exact length
  String? validateExactLength(int length, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (this!.length != length) {
      return message ?? 'Must be exactly $length characters';
    }

    return null;
  }

  /// Validate length range
  String? validateLengthRange(int min, int max, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (this!.length < min || this!.length > max) {
      return message ?? 'Must be between $min and $max characters';
    }

    return null;
  }

  /// Validate numeric value
  String? validateNumeric({String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (int.tryParse(this!) == null && double.tryParse(this!) == null) {
      return message ?? 'Enter a valid number';
    }

    return null;
  }

  /// Validate integer value
  String? validateInteger({String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (int.tryParse(this!) == null) {
      return message ?? 'Enter a valid integer';
    }

    return null;
  }

  /// Validate minimum value
  String? validateMin(num minValue, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    final number = num.tryParse(this!);
    if (number == null) {
      return message ?? 'Enter a valid number';
    }

    if (number < minValue) {
      return message ?? 'Value must be at least $minValue';
    }

    return null;
  }

  /// Validate maximum value
  String? validateMax(num maxValue, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    final number = num.tryParse(this!);
    if (number == null) {
      return message ?? 'Enter a valid number';
    }

    if (number > maxValue) {
      return message ?? 'Value must not exceed $maxValue';
    }

    return null;
  }

  /// Validate range
  String? validateRange(num minValue, num maxValue, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    final number = num.tryParse(this!);
    if (number == null) {
      return message ?? 'Enter a valid number';
    }

    if (number < minValue || number > maxValue) {
      return message ?? 'Value must be between $minValue and $maxValue';
    }

    return null;
  }

  /// Validate password strength
  String? validatePassword({String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (this!.length < 8) {
      return message ?? 'Password must be at least 8 characters';
    }

    if (!this!.contains(RegExp(r'[A-Z]'))) {
      return message ?? 'Password must contain at least one uppercase letter';
    }

    if (!this!.contains(RegExp(r'[a-z]'))) {
      return message ?? 'Password must contain at least one lowercase letter';
    }

    if (!this!.contains(RegExp(r'[0-9]'))) {
      return message ?? 'Password must contain at least one digit';
    }

    if (!this!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return message ?? 'Password must contain at least one special character';
    }

    return null;
  }

  /// Validate password confirmation
  String? validatePasswordMatch(String? password, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (this != password) {
      return message ?? 'Passwords do not match';
    }

    return null;
  }

  /// Validate alphanumeric
  String? validateAlphanumeric({String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this!)) {
      return message ?? 'Only letters and numbers are allowed';
    }

    return null;
  }

  /// Validate alphabetic
  String? validateAlphabetic({String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(this!)) {
      return message ?? 'Only letters are allowed';
    }

    return null;
  }

  /// Validate matches pattern
  String? validatePattern(RegExp pattern, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (!pattern.hasMatch(this!)) {
      return message ?? 'Invalid format';
    }

    return null;
  }

  /// Validate credit card number (Luhn algorithm)
  String? validateCreditCard({String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    final cleaned = this!.replaceAll(RegExp(r'\s'), '');
    if (!RegExp(r'^\d+$').hasMatch(cleaned)) {
      return message ?? 'Enter a valid credit card number';
    }

    // Luhn algorithm
    var sum = 0;
    var alternate = false;
    for (var i = cleaned.length - 1; i >= 0; i--) {
      var digit = int.parse(cleaned[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      sum += digit;
      alternate = !alternate;
    }

    if (sum % 10 != 0) {
      return message ?? 'Enter a valid credit card number';
    }

    return null;
  }

  /// Validate contains substring
  String? validateContains(String substring, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (!this!.contains(substring)) {
      return message ?? 'Must contain "$substring"';
    }

    return null;
  }

  /// Validate does not contain substring
  String? validateNotContains(String substring, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (this!.contains(substring)) {
      return message ?? 'Must not contain "$substring"';
    }

    return null;
  }

  /// Validate starts with
  String? validateStartsWith(String prefix, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (!this!.startsWith(prefix)) {
      return message ?? 'Must start with "$prefix"';
    }

    return null;
  }

  /// Validate ends with
  String? validateEndsWith(String suffix, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (!this!.endsWith(suffix)) {
      return message ?? 'Must end with "$suffix"';
    }

    return null;
  }

  /// Validate is one of the allowed values
  String? validateOneOf(List<String> allowedValues, {String? message}) {
    if (this == null || this!.isEmpty) {
      return null;
    }

    if (!allowedValues.contains(this)) {
      return message ?? 'Must be one of: ${allowedValues.join(", ")}';
    }

    return null;
  }
}

/// Static validators class for backward compatibility
class Validators {
  Validators._();

  /// Validate required field
  static String? required(String? value, [String? fieldName]) {
    return value.validateRequired(message: '${fieldName ?? 'This field'} is required');
  }

  /// Validate email
  static String? email(String? value, [String? message]) {
    return value.validateEmail(message: message);
  }

  /// Validate phone number
  static String? phone(String? value, [String? message]) {
    return value.validatePhone(message: message);
  }

  /// Validate URL
  static String? url(String? value, [String? message]) {
    return value.validateUrl(message: message);
  }

  /// Validate minimum length
  static String? minLength(String? value, int length, [String? fieldName]) {
    return value.validateMinLength(
      length,
      message: fieldName != null ? '$fieldName must be at least $length characters' : null,
    );
  }

  /// Validate maximum length
  static String? maxLength(String? value, int length, [String? fieldName]) {
    return value.validateMaxLength(
      length,
      message: fieldName != null ? '$fieldName must not exceed $length characters' : null,
    );
  }

  /// Validate exact length
  static String? exactLength(String? value, int length, [String? fieldName]) {
    return value.validateExactLength(
      length,
      message: fieldName != null ? '$fieldName must be exactly $length characters' : null,
    );
  }

  /// Validate numeric value
  static String? numeric(String? value, [String? message]) {
    return value.validateNumeric(message: message);
  }

  /// Validate integer value
  static String? integer(String? value, [String? message]) {
    return value.validateInteger(message: message);
  }

  /// Validate minimum value
  static String? min(String? value, num minValue, [String? message]) {
    return value.validateMin(minValue, message: message);
  }

  /// Validate maximum value
  static String? max(String? value, num maxValue, [String? message]) {
    return value.validateMax(maxValue, message: message);
  }

  /// Validate range
  static String? range(String? value, num minValue, num maxValue, [String? message]) {
    return value.validateRange(minValue, maxValue, message: message);
  }

  /// Validate password strength
  static String? password(String? value, [String? message]) {
    return value.validatePassword(message: message);
  }

  /// Validate password confirmation
  static String? passwordConfirmation(String? value, String? password, [String? message]) {
    return value.validatePasswordMatch(password, message: message);
  }

  /// Validate alphanumeric
  static String? alphanumeric(String? value, [String? message]) {
    return value.validateAlphanumeric(message: message);
  }

  /// Validate alphabetic
  static String? alphabetic(String? value, [String? message]) {
    return value.validateAlphabetic(message: message);
  }

  /// Validate matches pattern
  static String? matches(String? value, RegExp pattern, [String? message]) {
    return value.validatePattern(pattern, message: message);
  }

  /// Validate credit card number (Luhn algorithm)
  static String? creditCard(String? value, [String? message]) {
    return value.validateCreditCard(message: message);
  }

  /// Compose multiple validators
  static String? Function(String?) compose(List<String? Function(String?)> validators) {
    return (value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }
}
