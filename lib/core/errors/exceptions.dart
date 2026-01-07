/// Base exception class for all custom exceptions
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

/// Exception thrown when network request fails
class ServerException extends AppException {
  const ServerException([super.message = 'Server error occurred', super.statusCode]);
}

/// Exception thrown when no internet connection
class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

/// Exception thrown when request times out
class TimeoutException extends AppException {
  const TimeoutException([super.message = 'Request timeout']);
}

/// Exception thrown when authentication fails
class AuthException extends AppException {
  const AuthException([super.message = 'Authentication failed', super.statusCode]);
}

/// Exception thrown when resource not found
class NotFoundException extends AppException {
  const NotFoundException([String message = 'Resource not found'])
      : super(message, 404);
}

/// Exception thrown when validation fails
class ValidationException extends AppException {
  const ValidationException([String message = 'Validation failed'])
      : super(message, 422);
}

/// Exception thrown when permission denied
class PermissionException extends AppException {
  const PermissionException([String message = 'Permission denied'])
      : super(message, 403);
}

/// Exception thrown for local storage errors
class CacheException extends AppException {
  const CacheException([super.message = 'Cache operation failed']);
}

/// Exception thrown for file operations
class FileException extends AppException {
  const FileException([super.message = 'File operation failed']);
}

/// Exception thrown for biometric authentication
class BiometricException extends AppException {
  const BiometricException([super.message = 'Biometric authentication failed']);
}

/// Exception thrown for general errors
class GeneralException extends AppException {
  const GeneralException([super.message = 'An error occurred']);
}

