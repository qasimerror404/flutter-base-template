import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../utils/extensions/context_extensions.dart';

/// Error display widget
class ErrorDisplayWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorDisplayWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: AppSizes.iconXXL,
              color: context.colorScheme.error,
            ),
            const SizedBox(height: AppSizes.p16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSizes.p24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(context.l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Inline error widget (for forms, lists, etc.)
class InlineErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const InlineErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.p16),
      decoration: BoxDecoration(
        color: context.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: context.colorScheme.onErrorContainer,
          ),
          const SizedBox(width: AppSizes.p12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: context.colorScheme.onErrorContainer,
              ),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: AppSizes.p8),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: onRetry,
              color: context.colorScheme.onErrorContainer,
            ),
          ],
        ],
      ),
    );
  }
}

