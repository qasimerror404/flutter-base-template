import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../services/isar_service.dart';
import '../services/logger_service.dart';

part 'theme_provider.g.dart';

/// App settings model for Isar
@collection
class AppSettings {
  Id id = 0; // Singleton - always use ID 0
  late String themeMode; // 'light', 'dark', 'system'
  late String language; // 'en', 'ar'
  DateTime? lastModified;

  AppSettings({
    this.themeMode = 'system',
    this.language = 'en',
    DateTime? lastModified,
  }) : lastModified = lastModified ?? DateTime.now();
}

/// Theme mode notifier
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _loadThemeMode();
    return ThemeMode.system;
  }

  /// Load theme mode from storage
  Future<void> _loadThemeMode() async {
    try {
      final settings = await _getSettings();
      if (settings != null) {
        state = _themeModeFromString(settings.themeMode);
      }
    } catch (e) {
      LoggerService.error('Failed to load theme mode', e);
    }
  }

  /// Set theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _saveThemeMode(mode);
  }

  /// Save theme mode to storage
  Future<void> _saveThemeMode(ThemeMode mode) async {
    try {
      final settings = await _getSettings() ?? AppSettings();
      settings.themeMode = _stringFromThemeMode(mode);
      settings.lastModified = DateTime.now();

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.appSettings.put(settings);
      });

      LoggerService.info('Theme mode saved: ${_stringFromThemeMode(mode)}');
    } catch (e) {
      LoggerService.error('Failed to save theme mode', e);
    }
  }

  /// Get settings from Isar
  Future<AppSettings?> _getSettings() async {
    try {
      return await IsarService.isar.appSettings.get(0);
    } catch (e) {
      return null;
    }
  }

  /// Convert ThemeMode to string
  String _stringFromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  /// Convert string to ThemeMode
  ThemeMode _themeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}

/// Theme mode provider
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  () => ThemeModeNotifier(),
);

/// Provider to check if dark mode is active
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  
  if (themeMode == ThemeMode.system) {
    // Get system brightness (this won't work perfectly without BuildContext)
    // In real usage, this would be checked in the widget tree
    return false; // Default to light in system mode
  }
  
  return themeMode == ThemeMode.dark;
});

