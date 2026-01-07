import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../constants/app_strings.dart';

/// Interceptor for adding authentication token to requests
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get auth token from secure storage
    final token = await _secureStorage.read(key: AppStrings.keyAuthToken);

    if (token != null && token.isNotEmpty) {
      // Add token to headers
      options.headers[AppStrings.headerAuthorization] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized - token expired/invalid
    if (err.response?.statusCode == 401) {
      // TODO: Implement token refresh logic here if needed
      // For now, just pass the error
    }

    handler.next(err);
  }
}

