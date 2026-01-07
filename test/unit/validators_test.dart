import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/core/utils/validators/validators.dart';

void main() {
  group('Validators', () {
    group('required', () {
      test('returns error when value is null', () {
        expect(Validators.required(null), isNotNull);
      });

      test('returns error when value is empty', () {
        expect(Validators.required(''), isNotNull);
      });

      test('returns error when value is whitespace', () {
        expect(Validators.required('   '), isNotNull);
      });

      test('returns null when value is valid', () {
        expect(Validators.required('test'), isNull);
      });
    });

    group('email', () {
      test('returns null for valid email', () {
        expect(Validators.email('test@example.com'), isNull);
      });

      test('returns error for invalid email', () {
        expect(Validators.email('invalid-email'), isNotNull);
        expect(Validators.email('test@'), isNotNull);
        expect(Validators.email('@example.com'), isNotNull);
      });

      test('returns null for empty value', () {
        expect(Validators.email(''), isNull);
        expect(Validators.email(null), isNull);
      });
    });

    group('minLength', () {
      test('returns error when length is less than minimum', () {
        expect(Validators.minLength('abc', 5), isNotNull);
      });

      test('returns null when length equals minimum', () {
        expect(Validators.minLength('abcde', 5), isNull);
      });

      test('returns null when length is greater than minimum', () {
        expect(Validators.minLength('abcdef', 5), isNull);
      });
    });

    group('numeric', () {
      test('returns null for valid integer', () {
        expect(Validators.numeric('123'), isNull);
      });

      test('returns null for valid decimal', () {
        expect(Validators.numeric('123.45'), isNull);
      });

      test('returns error for non-numeric value', () {
        expect(Validators.numeric('abc'), isNotNull);
        expect(Validators.numeric('12a34'), isNotNull);
      });
    });

    group('compose', () {
      test('returns first error encountered', () {
        final validator = Validators.compose([
          Validators.required,
          (value) => Validators.minLength(value, 5),
          Validators.email,
        ]);

        expect(validator(''), isNotNull); // Fails required
        expect(validator('abc'), isNotNull); // Fails minLength
        expect(validator('abcde'), isNotNull); // Fails email
        expect(validator('test@example.com'), isNull); // All pass
      });
    });
  });
}

