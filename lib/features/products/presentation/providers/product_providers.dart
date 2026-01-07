import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/providers.dart';
import '../../data/datasources/product_local_datasource.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

// ========== Data Source Providers ==========

/// Remote data source provider
final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProductRemoteDataSource(dioClient);
});

/// Local data source provider
final productLocalDataSourceProvider = Provider<ProductLocalDataSource>((ref) {
  return ProductLocalDataSource();
});

// ========== Repository Provider ==========

/// Product repository provider
final productRepositoryProvider = Provider<IProductRepository>((ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  final localDataSource = ref.watch(productLocalDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);

  return ProductRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    networkInfo: networkInfo,
  );
});

// ========== Use Case / State Providers ==========

/// Products provider (AsyncNotifier)
final productsProvider =
    AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  () => ProductsNotifier(),
);

/// Products notifier
class ProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    return await _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final repository = ref.read(productRepositoryProvider);
    final result = await repository.getProducts();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (products) => products,
    );
  }

  /// Refresh products
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProducts());
  }

  /// Add product
  Future<void> addProduct(Product product) async {
    state = const AsyncValue.loading();
    
    final repository = ref.read(productRepositoryProvider);
    final result = await repository.createProduct(product);

    await result.fold(
      (failure) async {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (_) async {
        state = await AsyncValue.guard(() => _fetchProducts());
      },
    );
  }

  /// Update product
  Future<void> updateProduct(Product product) async {
    state = const AsyncValue.loading();
    
    final repository = ref.read(productRepositoryProvider);
    final result = await repository.updateProduct(product);

    await result.fold(
      (failure) async {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (_) async {
        state = await AsyncValue.guard(() => _fetchProducts());
      },
    );
  }

  /// Delete product
  Future<void> deleteProduct(String id) async {
    final repository = ref.read(productRepositoryProvider);
    final result = await repository.deleteProduct(id);

    await result.fold(
      (failure) async {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (_) async {
        state = await AsyncValue.guard(() => _fetchProducts());
      },
    );
  }

  /// Toggle favorite
  Future<void> toggleFavorite(String id) async {
    final repository = ref.read(productRepositoryProvider);
    final result = await repository.toggleFavorite(id);

    await result.fold(
      (failure) {
        // Show error but don't reload
      },
      (_) async {
        // Reload products
        state = await AsyncValue.guard(() => _fetchProducts());
      },
    );
  }

  /// Sync products
  Future<void> sync() async {
    final repository = ref.read(productRepositoryProvider);
    final result = await repository.syncProducts();

    await result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (_) async {
        state = await AsyncValue.guard(() => _fetchProducts());
      },
    );
  }
}

/// Favorite products provider
final favoriteProductsProvider =
    AsyncNotifierProvider<FavoriteProductsNotifier, List<Product>>(
  () => FavoriteProductsNotifier(),
);

/// Favorite products notifier
class FavoriteProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    return await _fetchFavorites();
  }

  Future<List<Product>> _fetchFavorites() async {
    final repository = ref.read(productRepositoryProvider);
    final result = await repository.getFavoriteProducts();

    return result.fold(
      (failure) => throw Exception(failure.message),
      (products) => products,
    );
  }

  /// Refresh favorites
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchFavorites());
  }
}

/// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Filtered products provider (based on search)
final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  if (searchQuery.isEmpty) {
    return productsAsync;
  }

  return productsAsync.whenData((products) {
    return products.where((product) {
      return product.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  });
});

/// Single product provider
final productProvider = FutureProvider.family<Product, String>((ref, id) async {
  final repository = ref.read(productRepositoryProvider);
  final result = await repository.getProductById(id);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (product) => product,
  );
});

