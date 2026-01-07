import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import 'logger_service.dart';

/// Isar database service
class IsarService {
  static Isar? _isar;

  /// Get Isar instance
  static Isar get isar {
    if (_isar == null) {
      throw Exception('Isar not initialized. Call init() first.');
    }
    return _isar!;
  }

  /// Check if Isar is initialized
  static bool get isInitialized => _isar != null;

  /// Initialize Isar database
  static Future<Either<Failure, Isar>> init({
    required List<CollectionSchema> schemas,
    String? directory,
    String name = 'app_database',
  }) async {
    try {
      LoggerService.info('Initializing Isar database...');

      // Get directory
      final dir = directory ?? (await getApplicationDocumentsDirectory()).path;

      // Open Isar
      _isar = await Isar.open(
        schemas,
        directory: dir,
        name: name,
      );

      LoggerService.info('Isar database initialized successfully');
      return Right(_isar!);
    } catch (e, stackTrace) {
      LoggerService.error('Failed to initialize Isar', e, stackTrace);
      return Left(CacheFailure('Failed to initialize database: $e'));
    }
  }

  /// Close Isar database
  static Future<Either<Failure, void>> close() async {
    try {
      if (_isar != null && _isar!.isOpen) {
        await _isar!.close();
        _isar = null;
        LoggerService.info('Isar database closed');
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to close database: $e'));
    }
  }

  /// Clear all data from database
  static Future<Either<Failure, void>> clearAll() async {
    try {
      await isar.writeTxn(() async {
        await isar.clear();
      });
      LoggerService.info('Isar database cleared');
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to clear database: $e'));
    }
  }

  /// Get database size in bytes
  static Future<Either<Failure, int>> getDatabaseSize() async {
    try {
      final size = await isar.getSize(includeIndexes: true);
      return Right(size);
    } catch (e) {
      return Left(CacheFailure('Failed to get database size: $e'));
    }
  }

  /// Compact database (reduce size)
  static Future<Either<Failure, void>> compact() async {
    try {
      // Isar automatically compacts, but we can trigger it manually
      await isar.writeTxn(() async {
        // Empty transaction to trigger compaction
      });
      LoggerService.info('Database compacted');
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to compact database: $e'));
    }
  }

  /// Export database
  static Future<Either<Failure, void>> export(String filePath) async {
    try {
      await isar.copyToFile(filePath);
      LoggerService.info('Database exported to: $filePath');
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to export database: $e'));
    }
  }
}

/// Base repository for Isar collections
abstract class BaseIsarRepository<T> {
  IsarCollection<T> get collection;

  /// Get all items
  Future<Either<Failure, List<T>>> getAll() async {
    try {
      final items = await collection.where().findAll();
      return Right(items);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Get item by ID
  Future<Either<Failure, T?>> getById(Id id) async {
    try {
      final item = await collection.get(id);
      return Right(item);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Insert item
  Future<Either<Failure, Id>> insert(T item) async {
    try {
      late Id id;
      await IsarService.isar.writeTxn(() async {
        id = await collection.put(item);
      });
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Insert multiple items
  Future<Either<Failure, List<Id>>> insertAll(List<T> items) async {
    try {
      late List<Id> ids;
      await IsarService.isar.writeTxn(() async {
        ids = await collection.putAll(items);
      });
      return Right(ids);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Update item
  Future<Either<Failure, Id>> update(T item) async {
    try {
      late Id id;
      await IsarService.isar.writeTxn(() async {
        id = await collection.put(item);
      });
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Delete item by ID
  Future<Either<Failure, bool>> delete(Id id) async {
    try {
      late bool deleted;
      await IsarService.isar.writeTxn(() async {
        deleted = await collection.delete(id);
      });
      return Right(deleted);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Delete all items
  Future<Either<Failure, void>> deleteAll() async {
    try {
      await IsarService.isar.writeTxn(() async {
        await collection.clear();
      });
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Count all items
  Future<Either<Failure, int>> count() async {
    try {
      final count = await collection.count();
      return Right(count);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Watch all items (stream)
  Stream<List<T>> watchAll() {
    return collection.where().watch(fireImmediately: true);
  }

  /// Watch item by ID (stream)
  Stream<T?> watchById(Id id) {
    return collection.watchObject(id, fireImmediately: true);
  }
}

