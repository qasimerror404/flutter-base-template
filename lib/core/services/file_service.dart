import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../errors/failures.dart';
import '../network/dio_client.dart';

/// Service for file operations (download/upload)
class FileService {
  final DioClient _dioClient;

  FileService(this._dioClient);

  /// Download file
  Future<Either<Failure, File>> downloadFile(
    String url,
    String fileName, {
    Function(double)? onProgress,
  }) async {
    try {
      // Request storage permission
      final permission = await _requestStoragePermission();
      if (!permission) {
        return const Left(
          PermissionFailure('Storage permission denied'),
        );
      }

      // Get download directory
      final downloadDir = await _getDownloadDirectory();
      final filePath = '${downloadDir.path}/$fileName';

      // Download file
      await _dioClient.downloadFile(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1 && onProgress != null) {
            final progress = (received / total * 100);
            onProgress(progress);
          }
        },
      );

      final file = File(filePath);
      return Right(file);
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }

  /// Upload file
  Future<Either<Failure, String>> uploadFile(
    String endpoint,
    File file, {
    String? fileName,
    Map<String, dynamic>? additionalData,
    Function(double)? onProgress,
  }) async {
    try {
      // Validate file exists
      if (!await file.exists()) {
        return const Left(FileFailure('File does not exist'));
      }

      // Upload file
      final response = await _dioClient.uploadFile(
        endpoint,
        file.path,
        fileName: fileName ?? file.path.split('/').last,
        data: additionalData,
        onSendProgress: (sent, total) {
          if (total != -1 && onProgress != null) {
            final progress = (sent / total * 100);
            onProgress(progress);
          }
        },
      );

      // Return file URL from response
      if (response.data != null && response.data is Map) {
        final url = response.data['url'] ?? response.data['file_url'];
        if (url != null) {
          return Right(url.toString());
        }
      }

      return const Left(ServerFailure('Failed to get file URL from response'));
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }

  /// Get download directory
  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      // Use external storage downloads directory on Android
      return Directory('/storage/emulated/0/Download');
    } else {
      // Use documents directory on iOS
      return await getApplicationDocumentsDirectory();
    }
  }

  /// Request storage permission
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      // On Android 13+, use photos/videos/audio permissions
      if (await Permission.photos.isGranted) {
        return true;
      }

      final status = await Permission.photos.request();
      return status.isGranted;
    } else {
      // iOS doesn't need storage permission for downloads
      return true;
    }
  }

  /// Get file size
  Future<int> getFileSize(File file) async {
    return await file.length();
  }

  /// Get file size in readable format
  String getReadableFileSize(int bytes) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    var size = bytes.toDouble();
    var unitIndex = 0;

    while (size >= 1024 && unitIndex < units.length - 1) {
      size /= 1024;
      unitIndex++;
    }

    return '${size.toStringAsFixed(2)} ${units[unitIndex]}';
  }

  /// Delete file
  Future<Either<Failure, bool>> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return const Right(true);
      }
      return const Left(FileFailure('File does not exist'));
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }

  /// Check if file exists
  Future<bool> fileExists(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }

  /// Get temporary directory
  Future<Directory> getTempDirectory() async {
    return await getTemporaryDirectory();
  }

  /// Get application documents directory
  Future<Directory> getAppDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Clear temp directory
  Future<Either<Failure, bool>> clearTempDirectory() async {
    try {
      final tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
        await tempDir.create();
        return const Right(true);
      }
      return const Right(false);
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }
}

