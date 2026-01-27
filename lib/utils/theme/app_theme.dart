import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final theme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "NaughtyMonster",
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.darkRed,
      selectionColor: AppColors.darkRed.withValues(alpha: 0.3),
      selectionHandleColor: AppColors.darkRed,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.grey),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkRed, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkRed),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkRed),
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
        textStyle: TextStyle(fontFamily: "NaughtyMonster"),
      ),
    ),
  );
}
