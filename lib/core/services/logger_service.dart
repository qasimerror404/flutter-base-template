import 'package:logger/logger.dart';
import '../config/env_config.dart';

/// Centralized logging service
class LoggerService {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: EnvConfig.enableLogging ? Level.all : Level.off,
  );

  /// Log debug message
  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (EnvConfig.enableLogging) {
      _logger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log info message
  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (EnvConfig.enableLogging) {
      _logger.i(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log warning message
  static void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (EnvConfig.enableLogging) {
      _logger.w(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log error message
  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log fatal error message
  static void fatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// Log network request
  static void logRequest(String method, String url, {dynamic data}) {
    if (EnvConfig.enableLogging) {
      _logger.i('🌐 $method: $url${data != null ? '\nData: $data' : ''}');
    }
  }

  /// Log network response
  static void logResponse(int statusCode, String url, {dynamic data}) {
    if (EnvConfig.enableLogging) {
      _logger.i('✅ $statusCode: $url${data != null ? '\nData: $data' : ''}');
    }
  }

  /// Log network error
  static void logNetworkError(String url, dynamic error) {
    _logger.e('❌ Network Error: $url', error: error);
  }
}

