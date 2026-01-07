import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../constants/app_sizes.dart';
import '../providers/providers.dart';
import '../utils/extensions/context_extensions.dart';

/// Banner showing connectivity status
class ConnectivityBanner extends ConsumerWidget {
  final Widget child;

  const ConnectivityBanner({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityAsync = ref.watch(connectivityStreamProvider);

    return connectivityAsync.when(
      data: (connectivityResults) {
        final isOffline = connectivityResults.contains(ConnectivityResult.none);

        return Column(
          children: [
            if (isOffline)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.p8,
                  horizontal: AppSizes.p16,
                ),
                color: context.colorScheme.errorContainer,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      size: AppSizes.iconSM,
                      color: context.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: AppSizes.p8),
                    Text(
                      context.l10n.noInternetConnection,
                      style: TextStyle(
                        color: context.colorScheme.onErrorContainer,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(child: child),
          ],
        );
      },
      loading: () => child,
      error: (_, __) => child,
    );
  }
}

