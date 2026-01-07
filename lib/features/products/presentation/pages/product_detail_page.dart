import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../providers/product_providers.dart';

/// Product detail page
class ProductDetailPage extends ConsumerWidget {
  final String productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push(RouteNames.productEditPath(productId)),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirmed = await context.showConfirmDialog(
                title: context.l10n.deleteProduct,
                message: context.l10n.deleteProductConfirmation,
              );

              if (confirmed == true) {
                await ref.read(productsProvider.notifier).deleteProduct(productId);
                if (context.mounted) {
                  context.pop();
                  context.showSuccessSnackBar(context.l10n.productDeleted);
                }
              }
            },
          ),
        ],
      ),
      body: productAsync.when(
        data: (product) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.image != null)
                  Center(
                    child: Image.network(
                      product.image!,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                const SizedBox(height: AppSizes.p24),
                Text(
                  product.title,
                  style: context.textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSizes.p8),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppSizes.p16),
                if (product.category != null) ...[
                  Text(
                    'Category: ${product.category}',
                    style: context.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSizes.p8),
                ],
                if (product.rating != null) ...[
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: AppSizes.p4),
                      Text(
                        product.rating!.toStringAsFixed(1),
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.p16),
                ],
                Text(
                  product.description,
                  style: context.textTheme.bodyLarge,
                ),
              ],
            ),
          );
        },
        loading: () => const LoadingWidget(),
        error: (error, stack) => ErrorDisplayWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(productProvider(productId)),
        ),
      ),
    );
  }
}

