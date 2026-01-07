import 'package:dartz/dartz.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

/// Product repository implementation
class ProductRepositoryImpl implements IProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
    required ProductLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      // Check network connectivity
      final isConnected = await _networkInfo.isConnected;

      if (isConnected && !EnvConfig.useMockData) {
        // Fetch from remote
        final result = await _remoteDataSource.getProducts();

        return result.fold(
          (failure) async {
            // On failure, return cached data
            LoggerService.warning('Remote fetch failed, loading from cache');
            return await _getLocalProducts();
          },
          (products) async {
            // Save to local cache
            await _localDataSource.saveProducts(products);
            // Return entities
            return Right(products.map((model) => model.toEntity()).toList());
          },
        );
      } else {
        // Load from local cache
        return await _getLocalProducts();
      }
    } catch (e) {
      LoggerService.error('Error in getProducts', e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  /// Get products from local database
  Future<Either<Failure, List<Product>>> _getLocalProducts() async {
    final result = await _localDataSource.getProducts();
    return result.fold(
      (failure) => Left(failure),
      (products) => Right(products.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      // Try local first
      final localResult = await _localDataSource.getProductById(id);

      return await localResult.fold(
        (failure) async {
          // If not in local, try remote
          final isConnected = await _networkInfo.isConnected;
          
          if (!isConnected) {
            return const Left(NetworkFailure());
          }

          final remoteResult = await _remoteDataSource.getProductById(id);
          return remoteResult.fold(
            (failure) => Left(failure),
            (product) async {
              // Save to local
              await _localDataSource.saveProduct(product);
              return Right(product.toEntity());
            },
          );
        },
        (product) {
          if (product != null) {
            return Right(product.toEntity());
          }
          return const Left(NotFoundFailure('Product not found'));
        },
      );
    } catch (e) {
      LoggerService.error('Error in getProductById', e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);

      // Check network
      final isConnected = await _networkInfo.isConnected;

      if (isConnected && !EnvConfig.useMockData) {
        // Create in remote
        final result = await _remoteDataSource.createProduct(model);

        return result.fold(
          (failure) => Left(failure),
          (createdProduct) async {
            // Save to local
            await _localDataSource.saveProduct(createdProduct);
            return Right(createdProduct.toEntity());
          },
        );
      } else {
        // Save locally only (mock mode or offline)
        final result = await _localDataSource.saveProduct(model);
        return result.fold(
          (failure) => Left(failure),
          (savedProduct) => Right(savedProduct.toEntity()),
        );
      }
    } catch (e) {
      LoggerService.error('Error in createProduct', e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);

      // Check network
      final isConnected = await _networkInfo.isConnected;

      if (isConnected && !EnvConfig.useMockData) {
        // Update in remote
        final result = await _remoteDataSource.updateProduct(model);

        return result.fold(
          (failure) => Left(failure),
          (updatedProduct) async {
            // Save to local
            await _localDataSource.saveProduct(updatedProduct);
            return Right(updatedProduct.toEntity());
          },
        );
      } else {
        // Update locally only
        final result = await _localDataSource.saveProduct(model);
        return result.fold(
          (failure) => Left(failure),
          (savedProduct) => Right(savedProduct.toEntity()),
        );
      }
    } catch (e) {
      LoggerService.error('Error in updateProduct', e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      // Check network
      final isConnected = await _networkInfo.isConnected;

      if (isConnected && !EnvConfig.useMockData) {
        // Delete from remote
        final result = await _remoteDataSource.deleteProduct(id);

        return result.fold(
          (failure) => Left(failure),
          (_) async {
            // Delete from local
            await _localDataSource.deleteProduct(id);
            return const Right(null);
          },
        );
      } else {
        // Delete from local only
        return await _localDataSource.deleteProduct(id);
      }
    } catch (e) {
      LoggerService.error('Error in deleteProduct', e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(String query) async {
    try {
      final result = await _localDataSource.searchProducts(query);
      return result.fold(
        (failure) => Left(failure),
        (products) => Right(products.map((model) => model.toEntity()).toList()),
      );
    } catch (e) {
      LoggerService.error('Error in searchProducts', e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
    String category,
  ) async {
    try {
      // Get all products and filter by category
      final result = await getProducts();
      return result.fold(
        (failure) => Left(failure),
        (products) {
          final filtered = products
              .where((product) => product.category == category)
              .toList();
          return Right(filtered);
        },
      );
    } catch (e) {
      LoggerService.error('Error in getProductsByCategory', e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> toggleFavorite(String id) async {
    try {
      final result = await _localDataSource.toggleFavorite(id);
      return result.fold(
        (failure) => Left(failure),
        (product) => Right(product.toEntity()),
      );
    } catch (e) {
      LoggerService.error('Error in toggleFavorite', e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFavoriteProducts() async {
    try {
      final result = await _localDataSource.getFavoriteProducts();
      return result.fold(
        (failure) => Left(failure),
        (products) => Right(products.map((model) => model.toEntity()).toList()),
      );
    } catch (e) {
      LoggerService.error('Error in getFavoriteProducts', e);
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> syncProducts() async {
    try {
      final isConnected = await _networkInfo.isConnected;

      if (!isConnected) {
        return const Left(NetworkFailure());
      }

      // Fetch from remote
      final result = await _remoteDataSource.getProducts();

      return result.fold(
        (failure) => Left(failure),
        (products) async {
          // Clear local and save new data
          await _localDataSource.clearProducts();
          await _localDataSource.saveProducts(products);
          LoggerService.info('Products synced successfully');
          return const Right(null);
        },
      );
    } catch (e) {
      LoggerService.error('Error in syncProducts', e);
      return Left(GeneralFailure(e.toString()));
    }
  }
}

