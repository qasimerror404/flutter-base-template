import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import '../errors/failures.dart';
import '../constants/app_strings.dart';

/// Service for image picking and processing
class ImagePickerService {
  final ImagePicker _picker;

  ImagePickerService(this._picker);

  /// Pick image from gallery
  Future<Either<Failure, File>> pickFromGallery({
    int quality = 85,
    double? maxWidth,
    double? maxHeight,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: quality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

      if (image == null) {
        return const Left(FileFailure('No image selected'));
      }

      return Right(File(image.path));
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }

  /// Pick image from camera
  Future<Either<Failure, File>> pickFromCamera({
    int quality = 85,
    double? maxWidth,
    double? maxHeight,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: quality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        preferredCameraDevice: preferredCameraDevice,
      );

      if (image == null) {
        return const Left(FileFailure('No image captured'));
      }

      return Right(File(image.path));
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }

  /// Pick multiple images from gallery
  Future<Either<Failure, List<File>>> pickMultiple({
    int limit = AppStrings.maxImagesSelection,
    int quality = 85,
    double? maxWidth,
    double? maxHeight,
  }) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: quality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );

      if (images.isEmpty) {
        return const Left(FileFailure('No images selected'));
      }

      // Limit number of images
      final limitedImages = images.take(limit).toList();
      final files = limitedImages.map((image) => File(image.path)).toList();

      return Right(files);
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }

  /// Pick video from gallery
  Future<Either<Failure, File>> pickVideo({
    Duration maxDuration = const Duration(minutes: 5),
  }) async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: maxDuration,
      );

      if (video == null) {
        return const Left(FileFailure('No video selected'));
      }

      return Right(File(video.path));
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }

  /// Compress image
  Future<Either<Failure, File>> compressImage(
    File imageFile, {
    int quality = 85,
    int? maxWidth,
    int? maxHeight,
  }) async {
    try {
      // Read image
      final bytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(bytes);

      if (image == null) {
        return const Left(FileFailure('Failed to decode image'));
      }

      // Resize if needed
      if (maxWidth != null || maxHeight != null) {
        image = img.copyResize(
          image,
          width: maxWidth,
          height: maxHeight,
        );
      }

      // Compress
      final compressedBytes = img.encodeJpg(image, quality: quality);

      // Save compressed image
      final tempDir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final compressedFile = File('${tempDir.path}/compressed_$timestamp.jpg');
      await compressedFile.writeAsBytes(compressedBytes);

      return Right(compressedFile);
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }

  /// Get image size in bytes
  Future<int> getImageSize(File imageFile) async {
    return await imageFile.length();
  }

  /// Check if image size exceeds limit
  Future<bool> exceedsMaxSize(File imageFile, int maxSize) async {
    final size = await getImageSize(imageFile);
    return size > maxSize;
  }

  /// Validate image file
  Future<Either<Failure, bool>> validateImage(File imageFile) async {
    try {
      // Check if file exists
      if (!await imageFile.exists()) {
        return const Left(FileFailure('Image file does not exist'));
      }

      // Check file size
      final size = await getImageSize(imageFile);
      if (size > AppStrings.maxImageUploadSize) {
        return const Left(
          FileFailure('Image size exceeds maximum allowed size'),
        );
      }

      // Check if valid image
      final bytes = await imageFile.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) {
        return const Left(FileFailure('Invalid image file'));
      }

      return const Right(true);
    } catch (e) {
      return Left(FileFailure(e.toString()));
    }
  }
}

