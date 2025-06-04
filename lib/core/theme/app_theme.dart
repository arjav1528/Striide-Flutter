import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Primary brand colors
  static const Color _primaryColor = Color(0xFF590bbe);
  static const Color _primaryVariant = Color(0xFF4710be);
  static const Color _secondaryColor = Color(0xFF2418bc);
  static const Color _secondaryVariant = Color(0xFF3714bd);

  // Gradient colors (from your gradient container)
  static const List<Color> gradientColors = [
    Color(0xFF590bbe),
    Color(0xFF5a0bbe),
    Color(0xFF590bbe),
    Color(0xFF5a0cbe),
    Color(0xFF4710be),
    Color(0xFF3714bd),
    Color(0xFF2418bc),
  ];

  // Light theme colors
  static const Color _lightBackground = Color(0xFFFFFBFE);
  static const Color _lightSurface = Color(0xFFFFFBFE);
  static const Color _lightOnPrimary = Colors.white;
  static const Color _lightOnSecondary = Colors.white;
  static const Color _lightOnBackground = Color(0xFF1C1B1F);
  static const Color _lightOnSurface = Color(0xFF1C1B1F);
  static const Color _lightError = Color(0xFFBA1A1A);
  static const Color _lightOnError = Colors.white;

  // Dark theme colors
  static const Color _darkBackground = Color(0xFF1C1B1F);
  static const Color _darkSurface = Color(0xFF1C1B1F);
  static const Color _darkOnPrimary = Color(0xFF1C1B1F);
  static const Color _darkOnSecondary = Color(0xFF1C1B1F);
  static const Color _darkOnBackground = Color(0xFFE6E1E5);
  static const Color _darkOnSurface = Color(0xFFE6E1E5);
  static const Color _darkError = Color(0xFFFFB4AB);
  static const Color _darkOnError = Color(0xFF690005);

  // Custom colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color(0xFF424242);

  // Text styles
  static const String primaryFontFamily = 'Montserrat';
  static const String secondaryFontFamily = 'Inter';
  static const String bodyFontFamily = 'Nunito';
  static const String displayFontFamily = 'OoohBaby';

  // Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _primaryColor,
    onPrimary: _lightOnPrimary,
    secondary: _secondaryColor,
    onSecondary: _lightOnSecondary,
    error: _lightError,
    onError: _lightOnError,
    surface: _lightSurface,
    onSurface: _lightOnSurface,
  );

  // Dark Color Scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _primaryColor,
    onPrimary: _darkOnPrimary,
    secondary: _secondaryColor,
    onSecondary: _darkOnSecondary,
    error: _darkError,
    onError: _darkOnError,
    surface: _darkSurface,
    onSurface: _darkOnSurface,
  );

  // Text Theme
  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: colorScheme.onSurface,
      ),
      displayMedium: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      displaySmall: TextStyle(
        fontFamily: displayFontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      headlineLarge: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      headlineMedium: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      headlineSmall: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontFamily: secondaryFontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontFamily: secondaryFontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: colorScheme.onSurface,
      ),
      titleSmall: TextStyle(
        fontFamily: secondaryFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontFamily: bodyFontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: colorScheme.onSurface,
      ),
      labelLarge: TextStyle(
        fontFamily: secondaryFontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),
      labelMedium: TextStyle(
        fontFamily: secondaryFontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontFamily: secondaryFontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
    );
  }

  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: _buildTextTheme(lightColorScheme),
    scaffoldBackgroundColor: lightColorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.surface,
      foregroundColor: lightColorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: lightColorScheme.onSurface,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: lightColorScheme.primary,
        side: BorderSide(color: lightColorScheme.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightColorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: const TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: lightColorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: lightColorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightColorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightColorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: lightColorScheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: lightColorScheme.surface,
      selectedItemColor: lightColorScheme.primary,
      unselectedItemColor: lightColorScheme.onSurface.withOpacity(0.6),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    textTheme: _buildTextTheme(darkColorScheme),
    scaffoldBackgroundColor: darkColorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: darkColorScheme.surface,
      foregroundColor: darkColorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        fontFamily: primaryFontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkColorScheme.onSurface,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkColorScheme.primary,
        foregroundColor: darkColorScheme.onPrimary,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: darkColorScheme.primary,
        side: BorderSide(color: darkColorScheme.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkColorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: const TextStyle(
          fontFamily: secondaryFontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: darkColorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkColorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: darkColorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: darkColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: darkColorScheme.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkColorScheme.surface,
      selectedItemColor: darkColorScheme.primary,
      unselectedItemColor: darkColorScheme.onSurface.withOpacity(0.6),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkColorScheme.primary,
      foregroundColor: darkColorScheme.onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  // Helper methods
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: gradientColors,
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static BoxDecoration get gradientDecoration =>
      BoxDecoration(gradient: primaryGradient);

  static LinearGradient get shimmerGradient => LinearGradient(
    colors: [Colors.grey.shade300, Colors.grey.shade100, Colors.grey.shade300],
    stops: const [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
