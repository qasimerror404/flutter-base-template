import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/core/utils/extensions/string_extensions.dart';

void main() {
  group('StringExtensions', () {
    group('capitalize', () {
      test('capitalizes first letter', () {
        expect('hello'.capitalize, 'Hello');
        expect('HELLO'.capitalize, 'Hello');
      });

      test('returns empty string for empty input', () {
        expect(''.capitalize, '');
      });
    });

    group('isValidEmail', () {
      test('validates correct email', () {
        expect('test@example.com'.isValidEmail, true);
        expect('user.name@domain.co.uk'.isValidEmail, true);
      });

      test('invalidates incorrect email', () {
        expect('invalid-email'.isValidEmail, false);
        expect('test@'.isValidEmail, false);
        expect('@example.com'.isValidEmail, false);
      });
    });

    group('truncate', () {
      test('truncates long strings', () {
        expect('Hello World'.truncate(5), 'Hello...');
        expect('Test'.truncate(10), 'Test');
      });
    });

    group('numbersOnly', () {
      test('extracts only numbers', () {
        expect('abc123def456'.numbersOnly, '123456');
        expect('Phone: +1 (234) 567-8900'.numbersOnly, '12345678900');
      });
    });

    group('mask', () {
      test('masks string with asterisks', () {
        expect('1234567890'.mask(visibleStart: 2, visibleEnd: 2), '12******90');
        expect('secret'.mask(visibleStart: 1, visibleEnd: 1), 's****t');
      });
    });
  });

  group('NullableStringExtensions', () {
    test('isNullOrEmpty detects null and empty', () {
      expect(null.isNullOrEmpty, true);
      expect(''.isNullOrEmpty, true);
      expect('   '.isNullOrEmpty, true);
      expect('test'.isNullOrEmpty, false);
    });

    test('orDefault returns default for null', () {
      expect(null.orDefault('default'), 'default');
      expect('value'.orDefault('default'), 'value');
    });
  });
}

