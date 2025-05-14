
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightThemeData()
  {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFE63946),
        onPrimary: Colors.white,
        secondary: Color(0xFFA8DADC),
        onSecondary: Colors.black,
        surface: Color(0xFFF1FAEE),
        onSurface: Color(0xFF1D3557),
        error: Colors.red,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF1FAEE),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF457B9D),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardColor: const Color(0xFFA8DADC),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF1D3557)),
        bodyMedium: TextStyle(color: Color(0xFF1D3557)),
        titleLarge: TextStyle(color: Color(0xFF1D3557), fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE63946),
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
        primary: Color(0xFFE63946),
        onPrimary: Colors.black,
        secondary: Color(0xFFA8DADC),
        onSecondary: Colors.black,
        surface: Color(0xFF1D3557),
        onSurface: Color(0xFFF1FAEE),
        error: Colors.red,
        onError: Colors.black,
      ),
      scaffoldBackgroundColor: const Color(0xFF1D3557),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0B132B),
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardColor: const Color(0xFF0B132B),
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
      datePickerTheme: DatePickerThemeData(
        backgroundColor: const Color(0xFF1D3557),
        surfaceTintColor: Colors.transparent,

        headerBackgroundColor: const Color(0xFF457B9D),
        headerForegroundColor: Colors.white,
        headerHeadlineStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headerHelpStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),

        weekdayStyle: const TextStyle(
          color: Color(0xFFA8DADC),
        ),

        dayStyle: const TextStyle(
          color: Color(0xFFF1FAEE),
        ),
        dayForegroundColor: WidgetStatePropertyAll(Colors.white),
        todayForegroundColor: WidgetStatePropertyAll(Colors.white),
        todayBackgroundColor: WidgetStatePropertyAll(Color(0xFFE63946)),

        rangePickerBackgroundColor: const Color(0xFF1D3557),
        rangeSelectionBackgroundColor: const Color(0xFFE63946),
        rangeSelectionOverlayColor: WidgetStatePropertyAll(Colors.redAccent[100]),

        yearStyle: const TextStyle(
          color: Color(0xFFF1FAEE),
        ),
        yearForegroundColor: WidgetStatePropertyAll(Colors.white),
        yearBackgroundColor: WidgetStatePropertyAll(Color(0xFFE63946)),

        dividerColor: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        rangePickerShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),

        cancelButtonStyle: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        confirmButtonStyle: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),

      dialogTheme: const DialogTheme(
        backgroundColor: Color(0xFF1D3557),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: Color(0xFFF1FAEE),
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}