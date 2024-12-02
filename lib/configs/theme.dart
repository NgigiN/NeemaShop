import 'package:flutter/material.dart';

class AppTheme {
  // Main colors
  static const Color primaryColor = Color(0xFF90CAF9); // Soft blue
  static const Color secondaryColor = Color(0xFF97D8C4); // Mint green
  static const Color accentColor = Color(0xFFF2D096); // Warm sand
  static const Color backgroundColor = Color(0xFFF7F9FC); // Light gray-blue
  static const Color textColor = Color(0xFF2D4059); // Dark blue-gray
  static const Color specialColor = Color(0xFFB39DDB);
  // Additional colors
  static const Color errorColor = Color(0xFFE56B6F); // Soft red
  static const Color successColor = Color(0xFF81B29A); // Sage green
  static const Color surfaceColor = Colors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
        ),
        labelStyle: const TextStyle(color: textColor),
        floatingLabelStyle: const TextStyle(color: primaryColor),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: textColor.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
