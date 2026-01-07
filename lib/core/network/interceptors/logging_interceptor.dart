import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Interceptor for logging HTTP requests and responses
class LoggingInterceptor extends Interceptor {
  final Logger logger;

  LoggingInterceptor(this.logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('''
    ╔══════════════════════════════════════════════════════════════════════
    ║ 📤 REQUEST
    ╠══════════════════════════════════════════════════════════════════════
    ║ Method: ${options.method}
    ║ URL: ${options.uri}
    ║ Headers: ${options.headers}
    ║ Query Parameters: ${options.queryParameters}
    ║ Data: ${options.data}
    ╚══════════════════════════════════════════════════════════════════════
    ''');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.i('''
    ╔══════════════════════════════════════════════════════════════════════
    ║ 📥 RESPONSE
    ╠══════════════════════════════════════════════════════════════════════
    ║ Status Code: ${response.statusCode}
    ║ URL: ${response.requestOptions.uri}
    ║ Headers: ${response.headers}
    ║ Data: ${response.data}
    ╚══════════════════════════════════════════════════════════════════════
    ''');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('''
    ╔══════════════════════════════════════════════════════════════════════
    ║ ❌ ERROR
    ╠══════════════════════════════════════════════════════════════════════
    ║ Type: ${err.type}
    ║ Message: ${err.message}
    ║ URL: ${err.requestOptions.uri}
    ║ Status Code: ${err.response?.statusCode}
    ║ Data: ${err.response?.data}
    ║ Stack Trace: ${err.stackTrace}
    ╚══════════════════════════════════════════════════════════════════════
    ''');

    handler.next(err);
  }
}

