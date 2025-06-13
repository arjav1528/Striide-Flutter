class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // App Information
  static const String appName = 'Striide';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // API Configuration
  static const String baseUrl = 'https://api.striide.com';
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String idKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String themeKey = 'app_theme';
  static const String languageKey = 'app_language';
  static const String onboardingKey = 'onboarding_completed';
  static const String biometricKey = 'biometric_enabled';

  // Animation Durations (in milliseconds)
  static const int shortAnimationDuration = 200;
  static const int mediumAnimationDuration = 300;
  static const int longAnimationDuration = 500;
  static const int splashDuration = 2000;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // UI Constants
  static const double defaultBorderRadius = 12.0;
  static const double defaultCardElevation = 2.0;
  static const double defaultButtonHeight = 48.0;
  static const double defaultAppBarHeight = 56.0;

  // Spacing Constants
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing48 = 48.0;
  static const double spacing64 = 64.0;

  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeExtraLarge = 48.0;

  // Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeExtraLarge = 18.0;
  static const double fontSizeHeading = 24.0;
  static const double fontSizeTitle = 20.0;

  // Screen Breakpoints
  static const double mobileBreakpoint = 768.0;
  static const double tabletBreakpoint = 1024.0;
  static const double desktopBreakpoint = 1440.0;

  // Form Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // Regular Expressions
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phoneRegex = r'^\+?[1-9]\d{1,14}$';
  static const String passwordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$';

  // Social Media URLs
  static const String facebookUrl = 'https://facebook.com/striide';
  static const String twitterUrl = 'https://twitter.com/striide';
  static const String instagramUrl = 'https://instagram.com/striide';
  static const String linkedinUrl = 'https://linkedin.com/company/striide';

  // Support
  static const String supportEmail = 'support@striide.com';
  static const String supportPhone = '+1-800-STRIIDE';
  static const String privacyPolicyUrl = 'https://striide.com/privacy';
  static const String termsOfServiceUrl = 'https://striide.com/terms';

  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentTypes = ['pdf', 'doc', 'docx'];

  // Cache
  static const int cacheExpiryHours = 24;
  static const int maxCacheSize = 100 * 1024 * 1024; // 100 MB

  // Error Messages
  static const String networkErrorMessage =
      'Network connection error. Please check your internet connection.';
  static const String serverErrorMessage =
      'Server error. Please try again later.';
  static const String unknownErrorMessage =
      'An unknown error occurred. Please try again.';
  static const String sessionExpiredMessage =
      'Your session has expired. Please log in again.';

  // Success Messages
  static const String loginSuccessMessage = 'Login successful!';
  static const String logoutSuccessMessage = 'Logout successful!';
  static const String registrationSuccessMessage = 'Registration successful!';
  static const String profileUpdateSuccessMessage =
      'Profile updated successfully!';

  // Feature Flags (can be moved to remote config later)
  static const bool enableBiometricAuth = true;
  static const bool enableDarkMode = true;
  static const bool enableNotifications = true;
  static const bool enableAnalytics = true;
}
