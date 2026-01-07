import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/isar_service.dart';
import '../../../../core/services/logger_service.dart';
import '../models/product_model.dart';

/// Local data source for products (Isar)
class ProductLocalDataSource {
  /// Get all products from local database
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final products = await IsarService.isar.productModels
          .where()
          .sortByUpdatedAtDesc()
          .findAll();

      LoggerService.info('Fetched ${products.length} products from local DB');
      return Right(products);
    } catch (e) {
      LoggerService.error('Error fetching local products', e);
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Get product by ID from local database
  Future<Either<Failure, ProductModel?>> getProductById(String productId) async {
    try {
      final product = await IsarService.isar.productModels
          .filter()
          .productIdEqualTo(productId)
          .findFirst();

      return Right(product);
    } catch (e) {
      LoggerService.error('Error fetching local product', e);
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Save product to local database
  Future<Either<Failure, ProductModel>> saveProduct(ProductModel product) async {
    try {
      await IsarService.isar.writeTxn(() async {
        // Check if product already exists
        final existing = await IsarService.isar.productModels
            .filter()
            .productIdEqualTo(product.productId)
            .findFirst();

        if (existing != null) {
          // Update existing
          product = product.copyWith(
            id: existing.id,
            updatedAt: DateTime.now(),
          );
        }

        await IsarService.isar.productModels.put(product);
      });

      LoggerService.info('Product saved locally: ${product.productId}');
      return Right(product);
    } catch (e) {
      LoggerService.error('Error saving product locally', e);
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Save multiple products to local database
  Future<Either<Failure, void>> saveProducts(List<ProductModel> products) async {
    try {
      await IsarService.isar.writeTxn(() async {
        for (final product in products) {
          final existing = await IsarService.isar.productModels
              .filter()
              .productIdEqualTo(product.productId)
              .findFirst();

          if (existing != null) {
            product.id = existing.id;
            product.updatedAt = DateTime.now();
          }
        }

        await IsarService.isar.productModels.putAll(products);
      });

      LoggerService.info('Saved ${products.length} products locally');
      return const Right(null);
    } catch (e) {
      LoggerService.error('Error saving products locally', e);
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Delete product from local database
  Future<Either<Failure, void>> deleteProduct(String productId) async {
    try {
      await IsarService.isar.writeTxn(() async {
        final product = await IsarService.isar.productModels
            .filter()
            .productIdEqualTo(productId)
            .findFirst();

        if (product != null) {
          await IsarService.isar.productModels.delete(product.id);
        }
      });

      LoggerService.info('Product deleted locally: $productId');
      return const Right(null);
    } catch (e) {
      LoggerService.error('Error deleting product locally', e);
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Toggle favorite status
  Future<Either<Failure, ProductModel>> toggleFavorite(String productId) async {
    try {
      late ProductModel updatedProduct;

      await IsarService.isar.writeTxn(() async {
        final product = await IsarService.isar.productModels
            .filter()
            .productIdEqualTo(productId)
            .findFirst();

        if (product != null) {
          product.isFavorite = !product.isFavorite;
          product.updatedAt = DateTime.now();
          await IsarService.isar.productModels.put(product);
          updatedProduct = product;
        }
      });

      LoggerService.info('Favorite toggled for product: $productId');
      return Right(updatedProduct);
    } catch (e) {
      LoggerService.error('Error toggling favorite', e);
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Get favorite products
  Future<Either<Failure, List<ProductModel>>> getFavoriteProducts() async {
    try {
      final products = await IsarService.isar.productModels
          .filter()
          .isFavoriteEqualTo(true)
          .sortByUpdatedAtDesc()
          .findAll();

      LoggerService.info('Fetched ${products.length} favorite products');
      return Right(products);
    } catch (e) {
      LoggerService.error('Error fetching favorite products', e);
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Search products locally
  Future<Either<Failure, List<ProductModel>>> searchProducts(String query) async {
    try {
      final products = await IsarService.isar.productModels
          .filter()
          .titleContains(query, caseSensitive: false)
          .or()
          .descriptionContains(query, caseSensitive: false)
          .findAll();

      LoggerService.info('Found ${products.length} products matching "$query"');
      return Right(products);
    } catch (e) {
      LoggerService.error('Error searching products', e);
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Clear all products
  Future<Either<Failure, void>> clearProducts() async {
    try {
      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.productModels.clear();
      });

      LoggerService.info('All products cleared from local DB');
      return const Right(null);
    } catch (e) {
      LoggerService.error('Error clearing products', e);
      return Left(CacheFailure(e.toString()));
    }
  }

  /// Watch products (stream)
  Stream<List<ProductModel>> watchProducts() {
    return IsarService.isar.productModels
        .where()
        .sortByUpdatedAtDesc()
        .watch(fireImmediately: true);
  }

  /// Watch favorite products (stream)
  Stream<List<ProductModel>> watchFavoriteProducts() {
    return IsarService.isar.productModels
        .filter()
        .isFavoriteEqualTo(true)
        .watch(fireImmediately: true);
  }
}

