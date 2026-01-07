import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../services/biometric_service.dart';
import '../services/file_service.dart';
import '../services/image_picker_service.dart';
import '../services/notification_service.dart';
import '../services/permission_service.dart';
import '../services/storage_service.dart';

// ========== Core Providers ==========

/// Dio provider
final dioProvider = Provider<Dio>((ref) {
  final dioClient = DioClient();
  return dioClient.dio;
});

/// DioClient provider
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

/// Connectivity provider
final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

/// NetworkInfo provider
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  return NetworkInfo(connectivity);
});

/// SharedPreferences provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be initialized in main()');
});

/// FlutterSecureStorage provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

/// LocalAuthentication provider
final localAuthProvider = Provider<LocalAuthentication>((ref) {
  return LocalAuthentication();
});

/// ImagePicker provider
final imagePickerProvider = Provider<ImagePicker>((ref) {
  return ImagePicker();
});

// ========== Service Providers ==========

/// StorageService provider
final storageServiceProvider = Provider<StorageService>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  return StorageService(prefs, secureStorage);
});

/// BiometricService provider
final biometricServiceProvider = Provider<BiometricService>((ref) {
  final localAuth = ref.watch(localAuthProvider);
  return BiometricService(localAuth);
});

/// ImagePickerService provider
final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
  final picker = ref.watch(imagePickerProvider);
  return ImagePickerService(picker);
});

/// FileService provider
final fileServiceProvider = Provider<FileService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FileService(dioClient);
});

/// PermissionService provider
final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});

/// NotificationService provider
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

// ========== Connectivity Stream Provider ==========

/// Stream provider for connectivity status
final connectivityStreamProvider =
    StreamProvider<List<ConnectivityResult>>((ref) {
  final connectivity = ref.watch(connectivityProvider);
  return connectivity.onConnectivityChanged;
});

/// Provider for checking if connected
final isConnectedProvider = FutureProvider<bool>((ref) async {
  final networkInfo = ref.watch(networkInfoProvider);
  return await networkInfo.isConnected;
});

