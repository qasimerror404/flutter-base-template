import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/env_config.dart';
import 'core/providers/language_provider.dart';
import 'core/providers/providers.dart';
import 'core/providers/theme_provider.dart';
import 'core/router/app_router.dart';
import 'core/services/isar_service.dart';
import 'core/services/logger_service.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/connectivity_banner.dart';
import 'features/products/data/models/product_model.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Set environment (change to Environment.prod for production)
    EnvConfig.setEnvironment(Environment.dev);

    // Initialize SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();

    // Initialize Isar database
    await IsarService.init(schemas: [AppSettingsSchema, ProductModelSchema]);

    LoggerService.info('App initialized successfully');

    runApp(
      ProviderScope(
        overrides: [
          // Override SharedPreferences provider
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    LoggerService.fatal('Failed to initialize app', e, stackTrace);

    // Show error screen
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                const Text('Failed to initialize app'),
                const SizedBox(height: 8),
                Text(e.toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(languageProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      // Routing
      routerConfig: router,

      // Theme
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,

      // Localization
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Builder for connectivity banner
      builder: (context, child) {
        return ConnectivityBanner(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
