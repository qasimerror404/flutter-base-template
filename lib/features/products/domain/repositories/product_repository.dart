import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product.dart';

/// Product repository interface (contract)
abstract class IProductRepository {
  /// Get all products
  Future<Either<Failure, List<Product>>> getProducts();

  /// Get product by ID
  Future<Either<Failure, Product>> getProductById(String id);

  /// Create product
  Future<Either<Failure, Product>> createProduct(Product product);

  /// Update product
  Future<Either<Failure, Product>> updateProduct(Product product);

  /// Delete product
  Future<Either<Failure, void>> deleteProduct(String id);

  /// Search products
  Future<Either<Failure, List<Product>>> searchProducts(String query);

  /// Get products by category
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);

  /// Toggle favorite
  Future<Either<Failure, Product>> toggleFavorite(String id);

  /// Get favorite products
  Future<Either<Failure, List<Product>>> getFavoriteProducts();

  /// Sync products (from remote to local)
  Future<Either<Failure, void>> syncProducts();
}

