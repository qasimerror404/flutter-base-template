// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Flutter Core';

  @override
  String get welcome => 'Welcome';

  @override
  String get home => 'Home';

  @override
  String get products => 'Products';

  @override
  String get favorites => 'Favorites';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get language => 'Language';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get version => 'Version';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get retry => 'Retry';

  @override
  String get search => 'Search';

  @override
  String get noInternetConnection => 'No Internet Connection';

  @override
  String get addProduct => 'Add Product';

  @override
  String get editProduct => 'Edit Product';

  @override
  String get deleteProduct => 'Delete Product';

  @override
  String get deleteProductConfirmation =>
      'Are you sure you want to delete this product?';

  @override
  String get productName => 'Product Name';

  @override
  String get productDescription => 'Product Description';

  @override
  String get price => 'Price';

  @override
  String get productAdded => 'Product Added';

  @override
  String get productUpdated => 'Product Updated';

  @override
  String get productDeleted => 'Product Deleted';

  @override
  String get noProducts => 'No Products';

  @override
  String get noProductsDescription =>
      'No products found. Add a new product to get started.';

  @override
  String get noFavorites => 'No Favorites';

  @override
  String get noFavoritesDescription => 'You haven\'t added any favorites yet.';

  @override
  String get biometricAuthentication => 'Biometric Authentication';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get isRequired => 'is required';

  @override
  String get invalidEmail => 'Enter a valid email address';

  @override
  String get invalidPhone => 'Enter a valid phone number';

  @override
  String get invalidUrl => 'Enter a valid URL';

  @override
  String minLengthError(int length) {
    return 'Must be at least $length characters';
  }

  @override
  String maxLengthError(int length) {
    return 'Must not exceed $length characters';
  }

  @override
  String get passwordMinLength => 'Password must be at least 8 characters';

  @override
  String get passwordUppercase =>
      'Password must contain at least one uppercase letter';

  @override
  String get passwordLowercase =>
      'Password must contain at least one lowercase letter';

  @override
  String get passwordDigit => 'Password must contain at least one digit';

  @override
  String get passwordSpecialChar =>
      'Password must contain at least one special character';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get invalidNumber => 'Enter a valid number';

  @override
  String minValueError(num min) {
    return 'Value must be at least $min';
  }

  @override
  String maxValueError(num max) {
    return 'Value must not exceed $max';
  }

  @override
  String rangeError(num min, num max) {
    return 'Value must be between $min and $max';
  }
}
