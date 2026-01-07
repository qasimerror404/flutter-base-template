import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';

/// Interceptor for retrying failed requests
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  RetryInterceptor(
    this.dio, {
    this.maxRetries = ApiConstants.maxRetries,
    this.retryDelay = ApiConstants.retryDelay,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Only retry on network errors or timeout
    if (!_shouldRetry(err)) {
      return handler.next(err);
    }

    // Get retry count from request
    final attempts = err.requestOptions.extra['retry_attempts'] ?? 0;

    if (attempts >= maxRetries) {
      // Max retries reached
      return handler.next(err);
    }

    // Wait before retry
    await Future.delayed(retryDelay * (attempts + 1));

    // Increment retry count
    err.requestOptions.extra['retry_attempts'] = attempts + 1;

    try {
      // Retry the request
      final response = await dio.fetch(err.requestOptions);
      return handler.resolve(response);
    } catch (e) {
      // If retry fails, pass the error
      if (e is DioException) {
        return handler.next(e);
      }
      return handler.next(err);
    }
  }

  /// Check if request should be retried
  bool _shouldRetry(DioException err) {
    // Retry on connection timeout or network errors
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError ||
        (err.response?.statusCode != null &&
            err.response!.statusCode! >= 500);
  }
}

