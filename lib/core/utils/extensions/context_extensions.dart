import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';

/// Extension on BuildContext for common utilities
extension ContextExtensions on BuildContext {
  /// Get theme
  ThemeData get theme => Theme.of(this);

  /// Get color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Get text theme
  TextTheme get textTheme => theme.textTheme;

  /// Get localization
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  /// Get media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  Size get screenSize => mediaQuery.size;

  /// Get screen width
  double get screenWidth => screenSize.width;

  /// Get screen height
  double get screenHeight => screenSize.height;

  /// Get padding (safe area)
  EdgeInsets get padding => mediaQuery.padding;

  /// Get view insets (keyboard)
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  /// Get orientation
  Orientation get orientation => mediaQuery.orientation;

  /// Check if portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// Check if landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// Check if dark mode
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Check if light mode
  bool get isLightMode => theme.brightness == Brightness.light;

  /// Show snackbar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Show error snackbar
  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: colorScheme.error);
  }

  /// Show success snackbar
  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }

  /// Hide keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Request focus
  void requestFocus(FocusNode node) {
    FocusScope.of(this).requestFocus(node);
  }

  /// Check if can pop
  bool get canPop => GoRouter.of(this).canPop();
}

/// Extension on BuildContext for showing dialogs
extension DialogExtensions on BuildContext {
  /// Show alert dialog
  Future<T?> showAlertDialog<T>({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
  }) {
    return showDialog<T>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (cancelText != null)
            TextButton(onPressed: () => context.pop(), child: Text(cancelText)),
          if (confirmText != null)
            TextButton(
              onPressed: () {
                onConfirm?.call();
                context.pop();
              },
              child: Text(confirmText),
            ),
        ],
      ),
    );
  }

  /// Show confirmation dialog
  Future<bool?> showConfirmDialog({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
  }) {
    return showDialog<bool>(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: Text(cancelText ?? context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: Text(confirmText ?? context.l10n.confirm),
          ),
        ],
      ),
    );
  }

  /// Show loading dialog
  void showLoadingDialog() {
    showDialog(
      context: this,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  /// Hide loading dialog
  void hideLoadingDialog() {
    if (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    }
  }
}
