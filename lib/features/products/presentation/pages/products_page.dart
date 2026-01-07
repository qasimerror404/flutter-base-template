import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/shimmer_widget.dart';
import '../providers/product_providers.dart';

/// Products page
class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(filteredProductsProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.products),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () => ref.read(productsProvider.notifier).refresh(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppSizes.p16),
            child: TextField(
              decoration: InputDecoration(
                hintText: context.l10n.search,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          ref.read(searchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),

          // Products list
          Expanded(
            child: productsAsync.when(
              data: (products) {
                if (products.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.inventory_2_outlined,
                    title: context.l10n.noProducts,
                    message: context.l10n.noProductsDescription,
                    actionLabel: context.l10n.addProduct,
                    onAction: () => context.push(RouteNames.productAdd),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => ref.read(productsProvider.notifier).refresh(),
                  child: ListView.builder(
                    itemCount: products.length,
                    padding: const EdgeInsets.all(AppSizes.p16),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        child: ListTile(
                          leading: product.image != null
                              ? Image.network(product.image!, width: 50, height: 50, fit: BoxFit.cover)
                              : const Icon(Icons.inventory_2),
                          title: Text(product.title),
                          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: Icon(
                              product.isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: product.isFavorite ? Colors.red : null,
                            ),
                            onPressed: () {
                              ref.read(productsProvider.notifier).toggleFavorite(product.id);
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
                onRetry: () => ref.read(productsProvider.notifier).refresh(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteNames.productAdd),
        child: const Icon(Icons.add),
      ),
    );
  }
}

