/// Route names for the application
class RouteNames {
  RouteNames._();

  // Bottom Navigation Routes
  static const String home = '/';
  static const String products = '/products';
  static const String favorites = '/favorites';
  static const String profile = '/profile';

  // Product Routes
  static const String productDetail = '/product/:id';
  static const String productAdd = '/product/add';
  static const String productEdit = '/product/edit/:id';

  // Settings Routes
  static const String settings = '/settings';
  static const String settingsTheme = '/settings/theme';
  static const String settingsLanguage = '/settings/language';
  static const String settingsBiometric = '/settings/biometric';

  // Helper methods for parametrized routes
  static String productDetailPath(String id) => '/product/$id';
  static String productEditPath(String id) => '/product/edit/$id';
}

