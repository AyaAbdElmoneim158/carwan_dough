import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final theme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.lightWhite,
    appBarTheme: AppBarTheme(),
    fontFamily: "NaughtyMonster",
    primaryColor: AppColors.darkRed,
    colorScheme: ColorScheme.light(
      primary: AppColors.red, // Header background (selected date)
      onPrimary: AppColors.white, // Header text color
      onSurface: AppColors.black, // Calendar day text color
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.darkRed,
      selectionColor: AppColors.darkRed.withValues(alpha: 0.3),
      selectionHandleColor: AppColors.darkRed,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontFamily: 'Montserrat',
        color: AppColors.grey,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.w500,
        fontFamily: "Montserrat",
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkRed, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkRed, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkRed, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkRed,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          fontFamily: "Montserrat",
        ),
      ),
    ),
  );
}
