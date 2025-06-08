import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UIUtils {
  static late MediaQueryData _mediaQuery;
  static late Size _screenSize;
  static late double _devicePixelRatio;

  // Initialize the UIUtils with MediaQuery data
  static void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    _screenSize = _mediaQuery.size;
    _devicePixelRatio = _mediaQuery.devicePixelRatio;
  }

  // Screen dimensions
  static double get screenWidth => _screenSize.width;
  static double get screenHeight => _screenSize.height;
  static double get devicePixelRatio => _devicePixelRatio;

  // Safe area dimensions
  static EdgeInsets get safeAreaPadding => _mediaQuery.padding;
  static double get statusBarHeight => _mediaQuery.padding.top;
  static double get bottomSafeAreaHeight => _mediaQuery.padding.bottom;
  static double get safeAreaWidth => screenWidth;
  static double get safeAreaHeight =>
      screenHeight - statusBarHeight - bottomSafeAreaHeight;

  // Device type detection
  static bool get isMobile => screenWidth < 768;
  static bool get isTablet => screenWidth >= 768 && screenWidth < 1024;
  static bool get isDesktop => screenWidth >= 1024;
  static bool get isSmallMobile => screenWidth < 360;
  static bool get isLargeMobile => screenWidth >= 414;

  // Orientation
  static bool get isPortrait => _mediaQuery.orientation == Orientation.portrait;
  static bool get isLandscape =>
      _mediaQuery.orientation == Orientation.landscape;

  // Text scale factor
  static double get textScaleFactor => _mediaQuery.textScaleFactor;

  // Responsive width calculations
  static double widthPercentage(double percentage) {
    return screenWidth * (percentage / 100);
  }

  static double heightPercentage(double percentage) {
    return screenHeight * (percentage / 100);
  }

  // Responsive font sizes
  static double responsiveFontSize(double baseFontSize) {
    if (isSmallMobile) {
      return baseFontSize * 0.85;
    } else if (isLargeMobile) {
      return baseFontSize * 1.1;
    } else if (isTablet) {
      return baseFontSize * 1.2;
    } else if (isDesktop) {
      return baseFontSize * 1.3;
    }
    return baseFontSize;
  }

  // Common spacing values
  static double get spacing4 => 4.0;
  static double get spacing8 => 8.0;
  static double get spacing12 => 12.0;
  static double get spacing16 => 16.0;
  static double get spacing20 => 20.0;
  static double get spacing24 => 24.0;
  static double get spacing32 => 32.0;
  static double get spacing30 => 30.0;
  static double get spacing48 => 48.0;
  static double get spacing64 => 64.0;

  // Responsive spacing
  static double get responsiveSpacing {
    if (isMobile) return spacing16;
    if (isTablet) return spacing24;
    return spacing32;
  }

  static double get responsiveHorizontalPadding {
    if (isSmallMobile) return spacing12;
    if (isMobile) return spacing16;
    if (isTablet) return spacing32;
    return spacing48;
  }

  static double get responsiveVerticalPadding {
    if (isMobile) return spacing12;
    if (isTablet) return spacing20;
    return spacing24;
  }

  // Button dimensions
  static double get buttonHeight {
    if (isMobile) return 48.0;
    if (isTablet) return 56.0;
    return 64.0;
  }

  static double get buttonMinWidth {
    if (isMobile) return 120.0;
    if (isTablet) return 140.0;
    return 160.0;
  }

  // Card dimensions
  static double get cardBorderRadius {
    if (isMobile) return 8.0;
    if (isTablet) return 12.0;
    return 16.0;
  }

  static double get cardElevation {
    if (isMobile) return 2.0;
    return 4.0;
  }

  // Home screen specific dimensions
  static double get homeFeaturePanelWidth => 65.0;
  static double get homeFeaturePanelHeight => 254.0;
  static double get homeFeaturePanelTopOffset => 480.0;
  static double get homeFeaturePanelRightOffset => 0.0;

  static double get homeProfileButtonBottomOffset => 700.0;
  static double get homeProfileButtonRightOffset => 335.0;

  static double get homeFeatureIconSize => 25.0;
  static double get homeProfileButtonSize => 56.0;
  static double get homeProfileButtonBorderWidth => 3.0;

  // Common edge insets
  static EdgeInsets get allPadding16 => const EdgeInsets.all(16.0);
  static EdgeInsets get allPadding12 => const EdgeInsets.all(12.0);
  static EdgeInsets get allPadding8 => const EdgeInsets.all(8.0);

  static EdgeInsets get horizontalPadding16 =>
      const EdgeInsets.symmetric(horizontal: 16.0);
  static EdgeInsets get horizontalPadding20 =>
      const EdgeInsets.symmetric(horizontal: 20.0);
  static EdgeInsets get horizontalPadding24 =>
      const EdgeInsets.symmetric(horizontal: 24.0);

  static EdgeInsets get verticalPadding8 =>
      const EdgeInsets.symmetric(vertical: 8.0);
  static EdgeInsets get verticalPadding12 =>
      const EdgeInsets.symmetric(vertical: 12.0);
  static EdgeInsets get verticalPadding16 =>
      const EdgeInsets.symmetric(vertical: 16.0);

  // Responsive edge insets
  static EdgeInsets get responsiveHorizontalPaddingInsets =>
      EdgeInsets.symmetric(horizontal: responsiveHorizontalPadding);

  static EdgeInsets get responsiveVerticalPaddingInsets =>
      EdgeInsets.symmetric(vertical: responsiveVerticalPadding);

  static EdgeInsets get responsiveAllPaddingInsets =>
      EdgeInsets.all(responsiveSpacing);

  // Common SizedBox heights
  static Widget get verticalSpace4 => const SizedBox(height: 4);
  static Widget get verticalSpace8 => const SizedBox(height: 8);
  static Widget get verticalSpace12 => const SizedBox(height: 12);
  static Widget get verticalSpace16 => const SizedBox(height: 16);
  static Widget get verticalSpace20 => const SizedBox(height: 20);
  static Widget get verticalSpace24 => const SizedBox(height: 24);
  static Widget get verticalSpace32 => const SizedBox(height: 32);

  // Common SizedBox widths
  static Widget get horizontalSpace4 => const SizedBox(width: 4);
  static Widget get horizontalSpace8 => const SizedBox(width: 8);
  static Widget get horizontalSpace12 => const SizedBox(width: 12);
  static Widget get horizontalSpace16 => const SizedBox(width: 16);
  static Widget get horizontalSpace20 => const SizedBox(width: 20);
  static Widget get horizontalSpace24 => const SizedBox(width: 24);
  static Widget get horizontalSpace32 => const SizedBox(width: 32);
  static Widget get horizontalSpace48 => const SizedBox(width: 48);
  static Widget get horizontalSpace56 => const SizedBox(width: 56);
  static Widget get horizontalSpace64 => const SizedBox(width: 64);
  static Widget get horizontalSpace80 => const SizedBox(width: 80);
  static Widget get horizontalSpace96 => const SizedBox(width: 96);
  static Widget get horizontalSpace112 => const SizedBox(width: 112);
  static Widget get horizontalSpace128 => const SizedBox(width: 128);

  // Dynamic spacing
  static Widget verticalSpace(double height) => SizedBox(height: height);
  static Widget horizontalSpace(double width) => SizedBox(width: width);

  // Screen breakpoints
  static bool get isExtraSmallScreen => screenWidth < 360;
  static bool get isSmallScreen => screenWidth >= 360 && screenWidth < 576;
  static bool get isMediumScreen => screenWidth >= 576 && screenWidth < 768;
  static bool get isLargeScreen => screenWidth >= 768 && screenWidth < 992;
  static bool get isExtraLargeScreen => screenWidth >= 992;

  // Grid columns based on screen size
  static int get gridColumns {
    if (isExtraSmallScreen) return 1;
    if (isSmallScreen) return 1;
    if (isMediumScreen) return 2;
    if (isLargeScreen) return 3;
    return 4;
  }

  // Utility methods
  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static void showKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  static void setSystemUIOverlayStyle({
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
    Color? systemNavigationBarColor,
    Brightness? systemNavigationBarIconBrightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
        systemNavigationBarColor: systemNavigationBarColor,
        systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
      ),
    );
  }

  // Dialog sizing
  static double get dialogWidth {
    if (isMobile) return screenWidth * 0.9;
    if (isTablet) return screenWidth * 0.7;
    return screenWidth * 0.5;
  }

  static double get dialogMaxHeight => screenHeight * 0.8;

  // Bottom sheet sizing
  static double get bottomSheetMaxHeight => screenHeight * 0.9;
  static double get bottomSheetMinHeight => screenHeight * 0.3;

  // App bar height
  static double get appBarHeight => kToolbarHeight;

  // Common durations for animations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 500);

  // Get appropriate icon size based on screen
  static double get iconSizeSmall {
    if (isMobile) return 16.0;
    if (isTablet) return 18.0;
    return 20.0;
  }

  static double get iconSizeMedium {
    if (isMobile) return 24.0;
    if (isTablet) return 28.0;
    return 32.0;
  }

  static double get iconSizeLarge {
    if (isMobile) return 32.0;
    if (isTablet) return 40.0;
    return 48.0;
  }

  // Validate if context is still mounted
  static bool isContextMounted(BuildContext context) {
    return context.mounted;
  }
}
