import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/products/presentation/pages/product_form_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../widgets/bottom_nav_scaffold.dart';
import 'route_names.dart';

/// Global navigator key
final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

/// Router provider
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteNames.home,
    debugLogDiagnostics: true,
    routes: [
      // Shell route for bottom navigation
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          return BottomNavScaffold(child: child);
        },
        routes: [
          // Home
          GoRoute(
            path: RouteNames.home,
            name: RouteNames.home,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
            ),
          ),

          // Products
          GoRoute(
            path: RouteNames.products,
            name: RouteNames.products,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProductsPage(),
            ),
          ),

          // Favorites
          GoRoute(
            path: RouteNames.favorites,
            name: RouteNames.favorites,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const FavoritesPage(),
            ),
          ),

          // Profile
          GoRoute(
            path: RouteNames.profile,
            name: RouteNames.profile,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProfilePage(),
            ),
          ),
        ],
      ),

      // Product Detail (full screen)
      GoRoute(
        path: RouteNames.productDetail,
        name: RouteNames.productDetail,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductDetailPage(productId: productId);
        },
      ),

      // Add Product (full screen)
      GoRoute(
        path: RouteNames.productAdd,
        name: RouteNames.productAdd,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          return const ProductFormPage();
        },
      ),

      // Edit Product (full screen)
      GoRoute(
        path: RouteNames.productEdit,
        name: RouteNames.productEdit,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final productId = state.pathParameters['id']!;
          return ProductFormPage(productId: productId);
        },
      ),

      // Settings (full screen)
      GoRoute(
        path: RouteNames.settings,
        name: RouteNames.settings,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          return const SettingsPage();
        },
      ),
    ],

    // Error page
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('Page not found: ${state.matchedLocation}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),

    // Redirect logic (can be used for authentication guards)
    redirect: (context, state) {
      // TODO: Add authentication logic here if needed
      // Example:
      // final isAuthenticated = ref.read(authProvider);
      // final isLoginRoute = state.matchedLocation == RouteNames.login;
      // 
      // if (!isAuthenticated && !isLoginRoute) {
      //   return RouteNames.login;
      // }
      // 
      // if (isAuthenticated && isLoginRoute) {
      //   return RouteNames.home;
      // }

      return null; // No redirect
    },
  );
});

