import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';
import '../errors/failures.dart';

/// Service for handling app permissions
class PermissionService {
  /// Request camera permission
  Future<Either<Failure, bool>> requestCamera() async {
    return await _requestPermission(Permission.camera, 'Camera');
  }

  /// Request photos permission
  Future<Either<Failure, bool>> requestPhotos() async {
    return await _requestPermission(Permission.photos, 'Photos');
  }

  /// Request storage permission
  Future<Either<Failure, bool>> requestStorage() async {
    return await _requestPermission(Permission.storage, 'Storage');
  }

  /// Request microphone permission
  Future<Either<Failure, bool>> requestMicrophone() async {
    return await _requestPermission(Permission.microphone, 'Microphone');
  }

  /// Request location permission
  Future<Either<Failure, bool>> requestLocation() async {
    return await _requestPermission(Permission.location, 'Location');
  }

  /// Request notification permission
  Future<Either<Failure, bool>> requestNotification() async {
    return await _requestPermission(Permission.notification, 'Notification');
  }

  /// Request contacts permission
  Future<Either<Failure, bool>> requestContacts() async {
    return await _requestPermission(Permission.contacts, 'Contacts');
  }

  /// Check camera permission status
  Future<bool> get hasCameraPermission async {
    return await Permission.camera.isGranted;
  }

  /// Check photos permission status
  Future<bool> get hasPhotosPermission async {
    return await Permission.photos.isGranted;
  }

  /// Check storage permission status
  Future<bool> get hasStoragePermission async {
    return await Permission.storage.isGranted;
  }

  /// Check notification permission status
  Future<bool> get hasNotificationPermission async {
    return await Permission.notification.isGranted;
  }

  /// Check if permission is permanently denied
  Future<bool> isPermissionPermanentlyDenied(Permission permission) async {
    return await permission.isPermanentlyDenied;
  }

  /// Open app settings
  Future<Either<Failure, bool>> openSettings() async {
    try {
      final opened = await openAppSettings();
      return Right(opened);
    } catch (e) {
      return Left(PermissionFailure(e.toString()));
    }
  }

  /// Request multiple permissions
  Future<Either<Failure, Map<Permission, bool>>> requestMultiple(
    List<Permission> permissions,
  ) async {
    try {
      final statuses = await permissions.request();
      final results = <Permission, bool>{};

      for (final permission in permissions) {
        results[permission] = statuses[permission]?.isGranted ?? false;
      }

      return Right(results);
    } catch (e) {
      return Left(PermissionFailure(e.toString()));
    }
  }

  /// Internal method to request permission
  Future<Either<Failure, bool>> _requestPermission(
    Permission permission,
    String permissionName,
  ) async {
    try {
      final status = await permission.status;

      // Already granted
      if (status.isGranted) {
        return const Right(true);
      }

      // Permanently denied
      if (status.isPermanentlyDenied) {
        return Left(
          PermissionFailure(
            '$permissionName permission is permanently denied. Please enable it in settings.',
          ),
        );
      }

      // Request permission
      final result = await permission.request();

      if (result.isGranted) {
        return const Right(true);
      } else if (result.isPermanentlyDenied) {
        return Left(
          PermissionFailure(
            '$permissionName permission is permanently denied. Please enable it in settings.',
          ),
        );
      } else {
        return Left(PermissionFailure('$permissionName permission denied'));
      }
    } catch (e) {
      return Left(PermissionFailure(e.toString()));
    }
  }
}

