# Validators Guide

## Overview

This project provides **three ways** to validate form inputs with full localization support:

1. **Extension Methods with Custom Messages** - For maximum flexibility
2. **Localized Validators** - For automatic language support (Arabic/English)
3. **Static Methods** - For backward compatibility

---

## 1. Extension Methods with Custom Messages

**File:** `lib/core/utils/validators/validators.dart`

### Usage

```dart
TextFormField(
  validator: (value) => value.validateRequired(
    message: 'Username is required',
  ),
)

TextFormField(
  validator: (value) => value.validateEmail(
    message: 'Please enter a valid email',
  ),
)

// Chaining validators
TextFormField(
  validator: (value) =>
    value.validateRequired(message: 'Required') ??
    value.validateMinLength(8, message: 'Too short') ??
    value.validatePassword(message: 'Weak password'),
)
```

### Available Methods

- `validateRequired({String? message})`
- `validateEmail({String? message})`
- `validatePhone({String? message})`
- `validateUrl({String? message})`
- `validateMinLength(int length, {String? message})`
- `validateMaxLength(int length, {String? message})`
- `validateExactLength(int length, {String? message})`
- `validateLengthRange(int min, int max, {String? message})`
- `validateNumeric({String? message})`
- `validateInteger({String? message})`
- `validateMin(num minValue, {String? message})`
- `validateMax(num maxValue, {String? message})`
- `validateRange(num minValue, num maxValue, {String? message})`
- `validatePassword({String? message})`
- `validatePasswordMatch(String? password, {String? message})`
- `validateAlphanumeric({String? message})`
- `validateAlphabetic({String? message})`
- `validatePattern(RegExp pattern, {String? message})`
- `validateCreditCard({String? message})`
- `validateContains(String substring, {String? message})`
- `validateNotContains(String substring, {String? message})`
- `validateStartsWith(String prefix, {String? message})`
- `validateEndsWith(String suffix, {String? message})`
- `validateOneOf(List<String> allowedValues, {String? message})`

---

## 2. Localized Validators (Recommended)

**File:** `lib/core/utils/validators/localized_validators.dart`

Automatically uses the app's current locale (English/Arabic).

### Usage

```dart
import '../../../core/utils/validators/localized_validators.dart';

// Simple usage
TextFormField(
  validator: (value) => value.requiredLocalized(context),
  // Shows "This field is required" in English
  // Shows "هذا الحقل مطلوب" in Arabic
)

// Email validation
TextFormField(
  validator: (value) => value.emailLocalized(context),
  // Shows "Enter a valid email address" in English
  // Shows "الرجاء إدخال عنوان بريد إلكتروني صحيح" in Arabic
)

// Chaining localized validators
TextFormField(
  validator: (value) =>
    value.requiredLocalized(context) ??
    value.passwordLocalized(context),
)

// With field name
TextFormField(
  validator: (value) => value.requiredLocalized(
    context,
    fieldName: 'Username', // Shows "Username is required"
  ),
)
```

### Available Localized Methods

- `requiredLocalized(BuildContext context, {String? fieldName})`
- `emailLocalized(BuildContext context)`
- `phoneLocalized(BuildContext context)`
- `urlLocalized(BuildContext context)`
- `minLengthLocalized(BuildContext context, int length)`
- `maxLengthLocalized(BuildContext context, int length)`
- `passwordLocalized(BuildContext context)`
- `passwordMatchLocalized(BuildContext context, String? otherPassword)`
- `numericLocalized(BuildContext context)`
- `minValueLocalized(BuildContext context, num minValue)`
- `maxValueLocalized(BuildContext context, num maxValue)`
- `rangeLocalized(BuildContext context, num minValue, num maxValue)`

---

## 3. Static Methods (Backward Compatible)

**File:** `lib/core/utils/validators/validators.dart`

```dart
TextFormField(
  validator: (value) => Validators.required(value, 'Username'),
)

TextFormField(
  validator: (value) => Validators.email(value),
)

// Compose multiple validators
TextFormField(
  validator: Validators.compose([
    (value) => Validators.required(value),
    (value) => Validators.minLength(value, 8),
  ]),
)
```

---

## Complete Examples

### Login Form with Localized Validators

```dart
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) =>
                value.requiredLocalized(context) ??
                value.emailLocalized(context),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) =>
                value.requiredLocalized(context) ??
                value.minLengthLocalized(context, 8),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Process login
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
```

### Registration Form with Password Confirmation

```dart
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) =>
                value.requiredLocalized(context) ??
                value.passwordLocalized(context),
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Confirm Password'),
            obscureText: true,
            validator: (value) =>
                value.requiredLocalized(context) ??
                value.passwordMatchLocalized(context, _passwordController.text),
          ),
        ],
      ),
    );
  }
}
```

---

## Adding Custom Localized Messages

To add more validation messages:

### 1. Add to English ARB file (`lib/l10n/app_en.arb`):

```json
{
  "customError": "This is a custom error message",
  "customErrorWithParam": "Value must be at least {value}",
  "@customErrorWithParam": {
    "placeholders": {
      "value": {
        "type": "int"
      }
    }
  }
}
```

### 2. Add to Arabic ARB file (`lib/l10n/app_ar.arb`):

```json
{
  "customError": "هذه رسالة خطأ مخصصة",
  "customErrorWithParam": "القيمة يجب أن تكون {value} على الأقل"
}
```

### 3. Regenerate localization files:

```bash
flutter gen-l10n
```

### 4. Use in your validator extension:

```dart
extension MyCustomValidators on String? {
  String? validateCustom(BuildContext context) {
    if (/* validation logic */) {
      return AppLocalizations.of(context)!.customError;
    }
    return null;
  }
}
```

---

## Best Practices

1. **Use Localized Validators** for user-facing forms to support multiple languages
2. **Use Extension Methods with Custom Messages** when you need specific error messages
3. **Chain Validators** to apply multiple validations in sequence
4. **Return null** when validation passes
5. **Return early** - the first error message will be displayed

---

## Localization Messages Reference

All validation messages are defined in:
- `lib/l10n/app_en.arb` (English)
- `lib/l10n/app_ar.arb` (Arabic)

Current available messages:
- `fieldRequired` - "This field is required" / "هذا الحقل مطلوب"
- `invalidEmail` - Email validation error
- `invalidPhone` - Phone validation error
- `invalidUrl` - URL validation error
- `minLengthError` - Minimum length error (with placeholder)
- `maxLengthError` - Maximum length error (with placeholder)
- `passwordMinLength` - Password minimum length error
- `passwordUppercase` - Password uppercase requirement
- `passwordLowercase` - Password lowercase requirement
- `passwordDigit` - Password digit requirement
- `passwordSpecialChar` - Password special character requirement
- `passwordsDoNotMatch` - Password confirmation error
- `invalidNumber` - Number validation error
- `minValueError` - Minimum value error (with placeholder)
- `maxValueError` - Maximum value error (with placeholder)
- `rangeError` - Range validation error (with placeholders)

