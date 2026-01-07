import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import '../constants/app_strings.dart';

/// Service for biometric authentication
class BiometricService {
  final LocalAuthentication _localAuth;

  BiometricService(this._localAuth);

  /// Check if biometric is available on device
  Future<Either<Failure, bool>> isAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return Right(isAvailable && isDeviceSupported);
    } catch (e) {
      return Left(BiometricFailure(e.toString()));
    }
  }

  /// Get available biometric types
  Future<Either<Failure, List<BiometricType>>> getAvailableBiometrics() async {
    try {
      final biometrics = await _localAuth.getAvailableBiometrics();
      return Right(biometrics);
    } catch (e) {
      return Left(BiometricFailure(e.toString()));
    }
  }

  /// Authenticate user with biometrics
  Future<Either<Failure, bool>> authenticate({
    String reason = AppStrings.biometricReasonAuth,
    bool useErrorDialogs = true,
    bool stickyAuth = true,
    bool sensitiveTransaction = false,
  }) async {
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
          sensitiveTransaction: sensitiveTransaction,
          biometricOnly: true,
        ),
      );

      return Right(authenticated);
    } catch (e) {
      // Handle specific errors
      if (e.toString().contains(auth_error.notAvailable)) {
        return Left(BiometricFailure('Biometric not available'));
      } else if (e.toString().contains(auth_error.notEnrolled)) {
        return Left(BiometricFailure('No biometric enrolled'));
      } else if (e.toString().contains(auth_error.lockedOut)) {
        return Left(BiometricFailure('Too many attempts, locked out'));
      } else if (e.toString().contains(auth_error.permanentlyLockedOut)) {
        return Left(
          BiometricFailure('Permanently locked out, use device credentials'),
        );
      }

      return Left(BiometricFailure(e.toString()));
    }
  }

  /// Authenticate with device credentials (PIN, pattern, password)
  Future<Either<Failure, bool>> authenticateWithDeviceCredentials({
    String reason = AppStrings.biometricReasonAuth,
  }) async {
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      return Right(authenticated);
    } catch (e) {
      return Left(BiometricFailure(e.toString()));
    }
  }

  /// Stop authentication
  Future<Either<Failure, bool>> stopAuthentication() async {
    try {
      await _localAuth.stopAuthentication();
      return const Right(true);
    } catch (e) {
      return Left(BiometricFailure(e.toString()));
    }
  }
}

