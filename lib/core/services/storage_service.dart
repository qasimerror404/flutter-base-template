import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../errors/failures.dart';

/// Service for local storage operations
class StorageService {
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secureStorage;

  StorageService(this._prefs, this._secureStorage);

  // ========== SharedPreferences ==========

  /// Save string
  Future<Either<Failure, bool>> saveString(String key, String value) async {
    try {
      final result = await _prefs.setString(key, value);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Get string
  Either<Failure, String?> getString(String key) {
    try {
      final value = _prefs.getString(key);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Save int
  Future<Either<Failure, bool>> saveInt(String key, int value) async {
    try {
      final result = await _prefs.setInt(key, value);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Get int
  Either<Failure, int?> getInt(String key) {
    try {
      final value = _prefs.getInt(key);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Save double
  Future<Either<Failure, bool>> saveDouble(String key, double value) async {
    try {
      final result = await _prefs.setDouble(key, value);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Get double
  Either<Failure, double?> getDouble(String key) {
    try {
      final value = _prefs.getDouble(key);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Save bool
  Future<Either<Failure, bool>> saveBool(String key, bool value) async {
    try {
      final result = await _prefs.setBool(key, value);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Get bool
  Either<Failure, bool?> getBool(String key) {
    try {
      final value = _prefs.getBool(key);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Save string list
  Future<Either<Failure, bool>> saveStringList(
    String key,
    List<String> value,
  ) async {
    try {
      final result = await _prefs.setStringList(key, value);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Get string list
  Either<Failure, List<String>?> getStringList(String key) {
    try {
      final value = _prefs.getStringList(key);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Remove key
  Future<Either<Failure, bool>> remove(String key) async {
    try {
      final result = await _prefs.remove(key);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Clear all preferences
  Future<Either<Failure, bool>> clear() async {
    try {
      final result = await _prefs.clear();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  /// Get all keys
  Set<String> getKeys() {
    return _prefs.getKeys();
  }

  // ========== Secure Storage ==========

  /// Save to secure storage
  Future<Either<Failure, void>> saveSecure(String key, String value) async {
    try {
      await _secureStorage.write(key: key, value: value);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Read from secure storage
  Future<Either<Failure, String?>> readSecure(String key) async {
    try {
      final value = await _secureStorage.read(key: key);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Delete from secure storage
  Future<Either<Failure, void>> deleteSecure(String key) async {
    try {
      await _secureStorage.delete(key: key);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Clear all secure storage
  Future<Either<Failure, void>> clearSecure() async {
    try {
      await _secureStorage.deleteAll();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Check if key exists in secure storage
  Future<Either<Failure, bool>> containsKeySecure(String key) async {
    try {
      final value = await _secureStorage.containsKey(key: key);
      return Right(value);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Get all keys from secure storage
  Future<Either<Failure, Map<String, String>>> readAllSecure() async {
    try {
      final all = await _secureStorage.readAll();
      return Right(all);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}

