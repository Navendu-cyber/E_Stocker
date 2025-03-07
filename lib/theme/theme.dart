import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_stocker/theme/colorpalette.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: AppColors.secondary,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16.0,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14.0,
        color: Colors.black,
      ),
    ),
    cardColor: const Color.fromARGB(255, 249, 246, 246),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.secondary,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        textStyle: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      elevation: 6,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: GoogleFonts.poppins(color: Colors.black),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade300,
      selectedColor: Colors.black,
      labelStyle: GoogleFonts.poppins(
        fontSize: 14.0,
        color: Colors.white,
      ),
      secondaryLabelStyle: GoogleFonts.poppins(
        fontSize: 14.0,
        color: Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: GoogleFonts.poppins(color: Colors.black54),
      labelStyle: GoogleFonts.poppins(color: Colors.black),
      prefixIconColor: Colors.black,
      suffixIconColor: Colors.black,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xFF222222), // Lighter black
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16.0,
        color: Colors.white70,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14.0,
        color: Colors.white,
      ),
    ),
    cardColor: const Color(0xFF2A2A2A), // Improved contrast
    cardTheme: CardTheme(
      color: const Color(0xFF2F2F2F), // Slightly lighter for contrast
      shadowColor: Colors.black.withOpacity(0.2), // Soft shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
            color: Colors.white30, width: 0.8), // Adds a subtle border
      ),
      elevation: 8, // More floating effect
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF222222), // Consistent with scaffold
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white70), // Softer white
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black.withOpacity(0.2),
        textStyle: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 6,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: GoogleFonts.poppins(color: Colors.white),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFF2A2A2A)),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade600, // Improved visibility
      selectedColor: Colors.white,
      labelStyle: GoogleFonts.poppins(
        fontSize: 14.0,
        color: Colors.black,
      ),
      secondaryLabelStyle: GoogleFonts.poppins(
        fontSize: 14.0,
        color: Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2E2E2E), // Better contrast
      hintStyle: GoogleFonts.poppins(color: Colors.white60),
      labelStyle: GoogleFonts.poppins(color: Colors.white),
      prefixIconColor: Colors.white70,
      suffixIconColor: Colors.white70,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white54),
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}
