class AppAssets {
  // Private constructor to prevent instantiation
  AppAssets._();

  // Font families
  static const String montserratFont = 'Montserrat';
  static const String interFont = 'Inter';
  static const String nunitoFont = 'Nunito';
  static const String ooohBabyFont = 'OoohBaby';

  // Icon paths
  static const String iconsPath = 'assets/icons/';
  static const String whatsappIcon = '${iconsPath}wa.svg';
  static const String facebookIcon = '${iconsPath}facebook.svg';
  static const String mailIcon = '${iconsPath}mail.svg';
  static const String xIcon = '${iconsPath}x.png';

  // Font paths
  static const String fontsPath = 'assets/fonts/';
  static const String montserratBold = '${fontsPath}Montserrat-Bold.ttf';
  static const String interBoldItalic = '${fontsPath}Inter_18pt-BoldItalic.ttf';
  static const String nunitoRegular = '${fontsPath}Nunito-Regular.ttf';
  static const String ooohBabyRegular = '${fontsPath}OoohBaby-Regular.ttf';

  // Environment file
  static const String envFile = '.env';

  // Asset validation methods
  static List<String> get allIconAssets => [
    whatsappIcon,
    facebookIcon,
    mailIcon,
    xIcon,
  ];

  static List<String> get allFontAssets => [
    montserratBold,
    interBoldItalic,
    nunitoRegular,
    ooohBabyRegular,
  ];

  static List<String> get allAssets => [
    ...allIconAssets,
    ...allFontAssets,
    envFile,
  ];

  // Helper methods for asset paths
  static String getIconPath(String iconName) {
    return '$iconsPath$iconName';
  }

  static String getFontPath(String fontName) {
    return '$fontsPath$fontName';
  }

  // Font family getters
  static String get primaryFont => montserratFont;
  static String get secondaryFont => interFont;
  static String get bodyFont => nunitoFont;
  static String get displayFont => ooohBabyFont;

  // Social media icons specifically
  static String get whatsApp => whatsappIcon;
  static String get facebook => facebookIcon;
  static String get email => mailIcon;
  static String get twitter => xIcon;
}
