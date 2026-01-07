import '../config/env_config.dart';

/// API-related constants
class ApiConstants {
  ApiConstants._();

  /// Base URL from environment config
  static String get baseUrl => EnvConfig.apiBaseUrl;

  /// Mock API URL (FakeStore API)
  static const String mockBaseUrl = 'https://fakestoreapi.com';

  /// Get the active base URL
  static String get activeBaseUrl => EnvConfig.useMockData ? mockBaseUrl : baseUrl;

  // API Versions
  static const String apiVersion = 'v1';

  // Endpoints
  static const String products = '/products';
  static const String categories = '/products/categories';
  static String productById(int id) => '/products/$id';
  static const String upload = '/upload';
  static const String download = '/download';

  // Query Parameters
  static const String paramLimit = 'limit';
  static const String paramPage = 'page';
  static const String paramSort = 'sort';
  static const String paramSearch = 'search';
  static const String paramCategory = 'category';

  // HTTP Status Codes
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusNoContent = 204;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusConflict = 409;
  static const int statusUnprocessableEntity = 422;
  static const int statusInternalServerError = 500;
  static const int statusServiceUnavailable = 503;

  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Retry
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}

