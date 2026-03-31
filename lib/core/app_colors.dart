import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryDarkBlue = Color(0xFF1976D2);

  // Background Colors
  static const Color backgroundColor = Color(0xFF1E1E1E);
  static const Color lightBackground = Color(0xFFF5F5F5);

  // Clock Colors
  static const Color clockGrey = Color(0xFF424242);
  static const Color clockRed = Color(0xFFE53935);
  static const Color clockOrange = Color(0xFFFB8C00);
  static const Color clockGreen = Color(0xFF43A047);
  static const Color clockPurple = Color(0xFF6E35B1);
  static const Color clockYellow = Color(0xFFFDD835);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFBDBDBD);

  // Status Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);

  // Get all clock colors as a list
  static const List<Color> clockColors = [
    clockGrey,
    clockRed,
    clockOrange,
    clockGreen,
    clockPurple,
    primaryBlue,
    clockYellow,
  ];
}
