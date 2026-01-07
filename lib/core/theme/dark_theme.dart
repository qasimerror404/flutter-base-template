import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Dark theme specific configurations
class DarkTheme {
  DarkTheme._();

  /// Custom colors for dark theme
  static const Color scaffoldBackground = AppColors.backgroundDark;
  static const Color cardBackground = AppColors.surfaceDark;
  static const Color dialogBackground = AppColors.surfaceDark;
  static const Color bottomSheetBackground = AppColors.surfaceDark;
  
  /// Shimmer colors for dark theme
  static const Color shimmerBase = AppColors.shimmerBaseDark;
  static const Color shimmerHighlight = AppColors.shimmerHighlightDark;
}

