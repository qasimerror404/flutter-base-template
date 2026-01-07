/// Extension on String for common operations
extension StringExtensions on String {
  /// Check if string is empty or null
  bool get isNullOrEmpty => trim().isEmpty;

  /// Check if string is not empty
  bool get isNotNullOrEmpty => trim().isNotEmpty;

  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalize each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Check if string is valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Check if string is valid phone
  bool get isValidPhone {
    return RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(this);
  }

  /// Check if string is valid URL
  bool get isValidUrl {
    return RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    ).hasMatch(this);
  }

  /// Check if string contains only numbers
  bool get isNumeric => RegExp(r'^[0-9]+$').hasMatch(this);

  /// Check if string contains only letters
  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Check if string is alphanumeric
  bool get isAlphanumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Truncate string with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Convert to int safely
  int? get toIntOrNull => int.tryParse(this);

  /// Convert to double safely
  double? get toDoubleOrNull => double.tryParse(this);

  /// Reverse string
  String get reverse => split('').reversed.join('');

  /// Count words
  int get wordCount => trim().split(RegExp(r'\s+')).length;

  /// Check if string is palindrome
  bool get isPalindrome {
    final cleaned = toLowerCase().removeWhitespace;
    return cleaned == cleaned.reverse;
  }

  /// Add thousands separator to numbers
  String get withThousandsSeparator {
    return replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  /// Extract numbers from string
  String get numbersOnly => replaceAll(RegExp(r'[^0-9]'), '');

  /// Extract letters from string
  String get lettersOnly => replaceAll(RegExp(r'[^a-zA-Z]'), '');

  /// Convert to snake_case
  String get toSnakeCase {
    return replaceAllMapped(
      RegExp(r'([A-Z])'),
      (Match m) => '_${m[1]!.toLowerCase()}',
    ).replaceFirst(RegExp(r'^_'), '');
  }

  /// Convert to camelCase
  String get toCamelCase {
    final words = split(RegExp(r'[_\s]+'));
    if (words.isEmpty) return this;
    return words[0].toLowerCase() +
        words.skip(1).map((word) => word.capitalize).join('');
  }

  /// Convert to PascalCase
  String get toPascalCase {
    return split(RegExp(r'[_\s]+'))
        .map((word) => word.capitalize)
        .join('');
  }

  /// Mask string (for sensitive data)
  String mask({int visibleStart = 0, int visibleEnd = 0, String maskChar = '*'}) {
    if (length <= visibleStart + visibleEnd) return this;
    final start = substring(0, visibleStart);
    final end = substring(length - visibleEnd);
    final masked = maskChar * (length - visibleStart - visibleEnd);
    return '$start$masked$end';
  }

  /// Check if string contains substring (case insensitive)
  bool containsIgnoreCase(String substring) {
    return toLowerCase().contains(substring.toLowerCase());
  }

  /// Remove HTML tags
  String get removeHtmlTags => replaceAll(RegExp(r'<[^>]*>'), '');

  /// Encode for URL
  String get urlEncoded => Uri.encodeComponent(this);

  /// Decode from URL
  String get urlDecoded => Uri.decodeComponent(this);
}

/// Extension on nullable String
extension NullableStringExtensions on String? {
  /// Check if null or empty
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  /// Check if not null and not empty
  bool get isNotNullOrEmpty => this != null && this!.trim().isNotEmpty;

  /// Get value or default
  String orDefault([String defaultValue = '']) => this ?? defaultValue;
}

