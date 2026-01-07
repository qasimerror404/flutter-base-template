import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Light theme specific configurations
class LightTheme {
  LightTheme._();

  /// Custom colors for light theme
  static const Color scaffoldBackground = AppColors.background;
  static const Color cardBackground = AppColors.surface;
  static const Color dialogBackground = AppColors.surface;
  static const Color bottomSheetBackground = AppColors.surface;
  
  /// Shimmer colors for light theme
  static const Color shimmerBase = AppColors.shimmerBase;
  static const Color shimmerHighlight = AppColors.shimmerHighlight;
}

