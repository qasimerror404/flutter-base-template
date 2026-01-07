import 'package:dartz/dartz.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/logger_service.dart';
import '../models/product_model.dart';

/// Remote data source for products (API)
class ProductRemoteDataSource {
  final DioClient _dioClient;

  ProductRemoteDataSource(this._dioClient);

  /// Get all products from API
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final response = await _dioClient.get(ApiConstants.products);

      if (response.statusCode == ApiConstants.statusOk) {
        final List<dynamic> data = response.data as List<dynamic>;
        final products = data.map((json) => ProductModel.fromJson(json)).toList();
        
        LoggerService.info('Fetched ${products.length} products from API');
        return Right(products);
      }

      return Left(ServerFailure('Failed to fetch products: ${response.statusCode}'));
    } catch (e) {
      LoggerService.error('Error fetching products', e);
      
      if (e.toString().contains('SocketException')) {
        return const Left(NetworkFailure());
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Get product by ID from API
  Future<Either<Failure, ProductModel>> getProductById(String id) async {
    try {
      final response = await _dioClient.get(ApiConstants.productById(int.parse(id)));

      if (response.statusCode == ApiConstants.statusOk) {
        final product = ProductModel.fromJson(response.data);
        return Right(product);
      }

      return Left(ServerFailure('Failed to fetch product: ${response.statusCode}'));
    } catch (e) {
      LoggerService.error('Error fetching product', e);
      
      if (e.toString().contains('SocketException')) {
        return const Left(NetworkFailure());
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Create product via API
  Future<Either<Failure, ProductModel>> createProduct(ProductModel product) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.products,
        data: product.toJson(),
      );

      if (response.statusCode == ApiConstants.statusCreated ||
          response.statusCode == ApiConstants.statusOk) {
        final createdProduct = ProductModel.fromJson(response.data);
        LoggerService.info('Product created: ${createdProduct.productId}');
        return Right(createdProduct);
      }

      return Left(ServerFailure('Failed to create product: ${response.statusCode}'));
    } catch (e) {
      LoggerService.error('Error creating product', e);
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Update product via API
  Future<Either<Failure, ProductModel>> updateProduct(ProductModel product) async {
    try {
      final response = await _dioClient.put(
        ApiConstants.productById(int.parse(product.productId)),
        data: product.toJson(),
      );

      if (response.statusCode == ApiConstants.statusOk) {
        final updatedProduct = ProductModel.fromJson(response.data);
        LoggerService.info('Product updated: ${updatedProduct.productId}');
        return Right(updatedProduct);
      }

      return Left(ServerFailure('Failed to update product: ${response.statusCode}'));
    } catch (e) {
      LoggerService.error('Error updating product', e);
      return Left(ServerFailure(e.toString()));
    }
  }

  /// Delete product via API
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      final response = await _dioClient.delete(
        ApiConstants.productById(int.parse(id)),
      );

      if (response.statusCode == ApiConstants.statusOk ||
          response.statusCode == ApiConstants.statusNoContent) {
        LoggerService.info('Product deleted: $id');
        return const Right(null);
      }

      return Left(ServerFailure('Failed to delete product: ${response.statusCode}'));
    } catch (e) {
      LoggerService.error('Error deleting product', e);
      return Left(ServerFailure(e.toString()));
    }
  }
}

