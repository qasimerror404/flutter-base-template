import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/providers/language_provider.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/extensions/context_extensions.dart';

/// Profile page
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(languageProvider);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profile)),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.p16),
        children: [
          // Theme setting
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: Text(context.l10n.theme),
            subtitle: Text(_getThemeModeText(context, themeMode)),
            onTap: () => _showThemeDialog(context, ref),
          ),

          // Language setting
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.l10n.language),
            subtitle: Text(
              locale.languageCode == 'en' ? context.l10n.english : context.l10n.arabic,
            ),
            onTap: () => _showLanguageDialog(context, ref),
          ),

          const Divider(),

          // Settings
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(context.l10n.settings),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => context.push(RouteNames.settings),
          ),

          // Version
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(context.l10n.version),
            subtitle: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }

  String _getThemeModeText(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return context.l10n.light;
      case ThemeMode.dark:
        return context.l10n.dark;
      case ThemeMode.system:
        return context.l10n.system;
    }
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.read(themeModeProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRadioOption<ThemeMode>(
              context: context,
              title: context.l10n.light,
              value: ThemeMode.light,
              currentValue: currentTheme,
              onTap: () {
                ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.light);
                context.pop();
              },
            ),
            _buildRadioOption<ThemeMode>(
              context: context,
              title: context.l10n.dark,
              value: ThemeMode.dark,
              currentValue: currentTheme,
              onTap: () {
                ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark);
                context.pop();
              },
            ),
            _buildRadioOption<ThemeMode>(
              context: context,
              title: context.l10n.system,
              value: ThemeMode.system,
              currentValue: currentTheme,
              onTap: () {
                ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.system);
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.read(languageProvider).languageCode;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRadioOption<String>(
              context: context,
              title: context.l10n.english,
              value: 'en',
              currentValue: currentLanguage,
              onTap: () {
                ref.read(languageProvider.notifier).changeLanguage('en');
                context.pop();
              },
            ),
            _buildRadioOption<String>(
              context: context,
              title: context.l10n.arabic,
              value: 'ar',
              currentValue: currentLanguage,
              onTap: () {
                ref.read(languageProvider.notifier).changeLanguage('ar');
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption<T>({
    required BuildContext context,
    required String title,
    required T value,
    required T currentValue,
    required VoidCallback onTap,
  }) {
    final isSelected = value == currentValue;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? context.colorScheme.primary : null,
            ),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
      ),
    );
  }
}
