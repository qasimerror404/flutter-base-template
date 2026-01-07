import 'package:equatable/equatable.dart';

/// Base failure class for error handling
/// Using Either<Failure, Success> pattern
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, [this.statusCode]);

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() => message;
}

/// Failure when server request fails
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred', super.statusCode]);
}

/// Failure when no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

/// Failure when request times out
class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Request timeout']);
}

/// Failure when authentication fails
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed', super.statusCode]);
}

/// Failure when resource not found
class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Resource not found'])
      : super(message, 404);
}

/// Failure when validation fails
class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'Validation failed'])
      : super(message, 422);
}

/// Failure when permission denied
class PermissionFailure extends Failure {
  const PermissionFailure([String message = 'Permission denied'])
      : super(message, 403);
}

/// Failure for local storage errors
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache operation failed']);
}

/// Failure for file operations
class FileFailure extends Failure {
  const FileFailure([super.message = 'File operation failed']);
}

/// Failure for biometric authentication
class BiometricFailure extends Failure {
  const BiometricFailure([super.message = 'Biometric authentication failed']);
}

/// General failure for unknown errors
class GeneralFailure extends Failure {
  const GeneralFailure([super.message = 'An error occurred']);
}

