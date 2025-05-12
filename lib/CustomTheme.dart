import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData lightThemeData()
  {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFE63946),     // Red - buttons, FABs
        onPrimary: Colors.white,
        secondary: Color(0xFFA8DADC),   // Light blue - accents
        onSecondary: Colors.black,
        surface: Color(0xFFF1FAEE),     // Off-white - main surfaces
        onSurface: Color(0xFF1D3557),   // Darkest blue - text/icons on surface
        background: Color(0xFFA8DADC),  // Light blue - optional background (modals)
        error: Colors.red,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF1FAEE), // surface color
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF457B9D), // Medium blue
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardColor: const Color(0xFFF1FAEE), // Match surface
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF1D3557)),
        bodyMedium: TextStyle(color: Color(0xFF1D3557)),
        titleLarge: TextStyle(color: Color(0xFF1D3557), fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE63946), // primary red
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFE63946),
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData darkThemeData()
  {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFE63946),     // Red - still the accent
        onPrimary: Colors.black,        // For text/icons on red buttons
        secondary: Color(0xFFA8DADC),   // Light blue - accent
        onSecondary: Colors.black,
        surface: Color(0xFF1D3557),     // Darkest blue - main UI surface
        onSurface: Color(0xFFF1FAEE),   // Off-white - readable text
        background: Color(0xFF0B132B),  // Deeper navy - optional backdrop
        error: Colors.red,
        onError: Colors.black,
      ),
      scaffoldBackgroundColor: const Color(0xFF1D3557), // same as surface
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0B132B), // Almost black navy
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardColor: const Color(0xFF1D3557),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFF1FAEE)),
        bodyMedium: TextStyle(color: Color(0xFFF1FAEE)),
        titleLarge: TextStyle(color: Color(0xFFF1FAEE), fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE63946),
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFFE63946),
        foregroundColor: Colors.black,
      ),
    );
  }
}