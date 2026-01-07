import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/isar_service.dart';
import '../services/logger_service.dart';
import 'theme_provider.dart';

/// Language notifier
class LanguageNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    _loadLanguage();
    return const Locale('en');
  }

  /// Load language from storage
  Future<void> _loadLanguage() async {
    try {
      final settings = await _getSettings();
      if (settings != null) {
        state = Locale(settings.language);
      }
    } catch (e) {
      LoggerService.error('Failed to load language', e);
    }
  }

  /// Set language
  Future<void> setLanguage(Locale locale) async {
    state = locale;
    await _saveLanguage(locale);
  }

  /// Change language by language code
  Future<void> changeLanguage(String languageCode) async {
    await setLanguage(Locale(languageCode));
  }

  /// Toggle between English and Arabic
  Future<void> toggleLanguage() async {
    final newLocale = state.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');
    await setLanguage(newLocale);
  }

  /// Save language to storage
  Future<void> _saveLanguage(Locale locale) async {
    try {
      final settings = await _getSettings() ?? AppSettings();
      settings.language = locale.languageCode;
      settings.lastModified = DateTime.now();

      await IsarService.isar.writeTxn(() async {
        await IsarService.isar.appSettings.put(settings);
      });

      LoggerService.info('Language saved: ${locale.languageCode}');
    } catch (e) {
      LoggerService.error('Failed to save language', e);
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
}

/// Language provider
final languageProvider = NotifierProvider<LanguageNotifier, Locale>(
  () => LanguageNotifier(),
);

/// Supported locales provider
final supportedLocalesProvider = Provider<List<Locale>>((ref) {
  return const [
    Locale('en'), // English
    Locale('ar'), // Arabic
  ];
});

/// Check if RTL
final isRTLProvider = Provider<bool>((ref) {
  final locale = ref.watch(languageProvider);
  return locale.languageCode == 'ar';
});

