import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _primaryColor = Color(0xFF2E7D32); // 落ち着いた緑
  static const _secondaryColor = Color(0xFF1976D2); // 信頼感のある青
  static const _backgroundColor = Color(0xFFFAFAFA); // オフホワイト
  static const _errorColor = Color(0xFFD32F2F); // 警告赤

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
        secondary: _secondaryColor,
        background: _backgroundColor,
        error: _errorColor,
      ),
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        titleTextStyle: GoogleFonts.notoSansJp(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: const TextStyle(fontSize: 16),
        hintStyle: const TextStyle(fontSize: 16),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        margin: EdgeInsets.all(8),
      ),
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.notoSansJp(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
      displayMedium: GoogleFonts.notoSansJp(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
      displaySmall: GoogleFonts.notoSansJp(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        height: 1.4,
      ),
      headlineLarge: GoogleFonts.notoSansJp(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      headlineMedium: GoogleFonts.notoSansJp(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      headlineSmall: GoogleFonts.notoSansJp(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
      ),
      titleLarge: GoogleFonts.notoSansJp(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      titleMedium: GoogleFonts.notoSansJp(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      titleSmall: GoogleFonts.notoSansJp(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      bodyLarge: GoogleFonts.notoSansJp(
        fontSize: 18,
        height: 1.7,
      ),
      bodyMedium: GoogleFonts.notoSansJp(
        fontSize: 16,
        height: 1.7,
      ),
      bodySmall: GoogleFonts.notoSansJp(
        fontSize: 14,
        height: 1.7,
      ),
      labelLarge: GoogleFonts.notoSansJp(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      labelMedium: GoogleFonts.notoSansJp(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
      labelSmall: GoogleFonts.notoSansJp(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.5,
      ),
    );
  }
}