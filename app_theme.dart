import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryAmber = Color(0xFFF59E0B);
  static const Color primaryAmberDark = Color(0xFFD97706);
  static const Color darkBg = Color(0xFF020617);
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkBorder = Color(0xFF334155);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textLight = Color(0xFFF8FAFC);
  static const Color emeraldAccent = Color(0xFF10B981);
  static const Color roseSos = Color(0xFFF43F5E);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryAmber,
      scaffoldBackgroundColor: darkBg,
      cardColor: darkCard,
      colorScheme: const ColorScheme.dark(
        primary: primaryAmber,
        secondary: emeraldAccent,
        surface: darkSurface,
        background: darkBg,
        error: roseSos,
      ),
    );
  }
}