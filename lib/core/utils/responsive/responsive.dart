import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';

/// Responsive utility class for handling different screen sizes
class Responsive {
  final BuildContext context;
  late final MediaQueryData _mediaQuery;
  late final Size _screenSize;

  Responsive(this.context) {
    _mediaQuery = MediaQuery.of(context);
    _screenSize = _mediaQuery.size;
  }

  /// Screen width
  double get width => _screenSize.width;

  /// Screen height
  double get height => _screenSize.height;

  /// Device pixel ratio
  double get pixelRatio => _mediaQuery.devicePixelRatio;

  /// Check if device is in portrait mode
  bool get isPortrait => _mediaQuery.orientation == Orientation.portrait;

  /// Check if device is in landscape mode
  bool get isLandscape => _mediaQuery.orientation == Orientation.landscape;

  /// Check if device is mobile (width < 600)
  bool get isMobile => width < AppSizes.mobileBreakpoint;

  /// Check if device is tablet (width >= 600 && width < 1024)
  bool get isTablet =>
      width >= AppSizes.mobileBreakpoint && width < AppSizes.tabletBreakpoint;

  /// Check if device is desktop (width >= 1024)
  bool get isDesktop => width >= AppSizes.tabletBreakpoint;

  /// Get responsive width based on percentage
  double widthPercent(double percent) => width * (percent / 100);

  /// Get responsive height based on percentage
  double heightPercent(double percent) => height * (percent / 100);

  /// Get responsive value based on screen type
  T value<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  /// Get responsive font size
  double fontSize(double size) {
    if (isMobile) return size;
    if (isTablet) return size * 1.1;
    return size * 1.2;
  }

  /// Get responsive spacing
  double spacing(double size) {
    if (isMobile) return size;
    if (isTablet) return size * 1.2;
    return size * 1.4;
  }

  /// Get responsive padding
  EdgeInsets padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: spacing(left ?? horizontal ?? all ?? 0),
      top: spacing(top ?? vertical ?? all ?? 0),
      right: spacing(right ?? horizontal ?? all ?? 0),
      bottom: spacing(bottom ?? vertical ?? all ?? 0),
    );
  }

  /// Get max content width for large screens
  double get maxContentWidth {
    if (width > AppSizes.maxContentWidth) {
      return AppSizes.maxContentWidth;
    }
    return width;
  }

  /// Get grid column count based on screen size
  int get gridColumns {
    if (isMobile) return 2;
    if (isTablet) return 3;
    return 4;
  }

  /// Get list columns based on screen size
  int get listColumns {
    if (isMobile) return 1;
    if (isTablet) return 2;
    return 3;
  }

  /// Static method to get Responsive instance
  static Responsive of(BuildContext context) => Responsive(context);
}

/// Extension on BuildContext for easy access
extension ResponsiveContext on BuildContext {
  Responsive get responsive => Responsive(this);

  /// Quick access to screen width
  double get width => MediaQuery.of(this).size.width;

  /// Quick access to screen height
  double get height => MediaQuery.of(this).size.height;

  /// Quick access to check if mobile
  bool get isMobile => width < AppSizes.mobileBreakpoint;

  /// Quick access to check if tablet
  bool get isTablet =>
      width >= AppSizes.mobileBreakpoint && width < AppSizes.tabletBreakpoint;

  /// Quick access to check if desktop
  bool get isDesktop => width >= AppSizes.tabletBreakpoint;

  /// Get responsive value
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}

/// Extension on numbers for responsive sizing
extension ResponsiveNum on num {
  /// Convert to responsive width
  double get w {
    // Base width: 375 (iPhone 11 Pro)
    final baseWidth = 375.0;
    final screenWidth = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    return (this * screenWidth) / baseWidth;
  }

  /// Convert to responsive height
  double get h {
    // Base height: 812 (iPhone 11 Pro)
    final baseHeight = 812.0;
    final screenHeight = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    return (this * screenHeight) / baseHeight;
  }

  /// Convert to responsive font size
  double get sp {
    // Font scaling based on width
    return w;
  }

  /// Convert to responsive radius
  double get r => w;
}

