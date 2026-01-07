import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../../../products/presentation/providers/product_providers.dart';

/// Favorites page
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.favorites),
      ),
      body: favoritesAsync.when(
        data: (favorites) {
          if (favorites.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.favorite_outline,
              title: context.l10n.noFavorites,
              message: context.l10n.noFavoritesDescription,
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(favoriteProductsProvider.notifier).refresh(),
            child: ListView.builder(
              itemCount: favorites.length,
              padding: const EdgeInsets.all(AppSizes.p16),
              itemBuilder: (context, index) {
                final product = favorites[index];
                return Card(
                  child: ListTile(
                    leading: product.image != null
                        ? Image.network(product.image!, width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.inventory_2),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        ref.read(productsProvider.notifier).toggleFavorite(product.id);
                        ref.read(favoriteProductsProvider.notifier).refresh();
                      },
                    ),
                    onTap: () => context.push(RouteNames.productDetailPath(product.id)),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const ShimmerList(),
        error: (error, stack) => ErrorDisplayWidget(
          message: error.toString(),
          onRetry: () => ref.read(favoriteProductsProvider.notifier).refresh(),
        ),
      ),
    );
  }
}

