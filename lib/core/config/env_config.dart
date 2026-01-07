/// Environment configuration for the application
/// Supports dev and prod environments
enum Environment { dev, prod }

class EnvConfig {
  static Environment _current = Environment.dev;

  /// Current environment
  static Environment get current => _current;

  /// Set current environment
  static void setEnvironment(Environment env) {
    _current = env;
  }

  /// Check if development environment
  static bool get isDev => _current == Environment.dev;

  /// Check if production environment
  static bool get isProd => _current == Environment.prod;

  /// API Base URL based on environment
  static String get apiBaseUrl {
    switch (_current) {
      case Environment.dev:
        return 'https://api-dev.example.com';
      case Environment.prod:
        return 'https://api.example.com';
    }
  }

  /// Use mock data (for testing without backend)
  static bool get useMockData => isDev;

  /// API timeout duration
  static Duration get apiTimeout => const Duration(seconds: 30);

  /// Enable logging
  static bool get enableLogging => isDev;

  /// Enable analytics
  static bool get enableAnalytics => isProd;
}

