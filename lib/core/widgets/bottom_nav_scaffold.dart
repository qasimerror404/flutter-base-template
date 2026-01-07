import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_sizes.dart';
import '../router/route_names.dart';
import '../utils/extensions/context_extensions.dart';

/// Scaffold with bottom navigation bar
class BottomNavScaffold extends StatelessWidget {
  final Widget child;

  const BottomNavScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        elevation: AppSizes.elevation8,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: context.l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.inventory_2_outlined),
            activeIcon: const Icon(Icons.inventory_2),
            label: context.l10n.products,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_outline),
            activeIcon: const Icon(Icons.favorite),
            label: context.l10n.favorites,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            activeIcon: const Icon(Icons.person),
            label: context.l10n.profile,
          ),
        ],
      ),
    );
  }

  /// Calculate selected index based on current location
  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    if (location.startsWith(RouteNames.products)) {
      return 1;
    } else if (location.startsWith(RouteNames.favorites)) {
      return 2;
    } else if (location.startsWith(RouteNames.profile)) {
      return 3;
    }
    return 0; // Home
  }

  /// Handle bottom navigation tap
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.products);
        break;
      case 2:
        context.go(RouteNames.favorites);
        break;
      case 3:
        context.go(RouteNames.profile);
        break;
    }
  }
}

