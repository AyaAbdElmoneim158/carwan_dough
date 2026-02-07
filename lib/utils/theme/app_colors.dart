import 'package:flutter/material.dart';

class AppColors {
  // Your existing colors
  static const Color red = Color(0xFFD81B32);
  static const Color darkRed = Color(0xFFc01836);
  static const Color white = Color(0xFFF1ECE7);
  static const Color lightWhite = Color(0xFFFFFFFF);
  static const Color black = Color.fromARGB(255, 28, 28, 27);
  static const Color grey = Color.fromARGB(255, 125, 120, 114);

  // Expanded color palette (matching your existing theme)

  // Red variations
  static const Color lightRed = Color(0xFFEB5757);
  static const Color paleRed = Color(0xFFFDE8E8);
  static const Color deepRed = Color(0xFF8B0000);

  // Green colors (requested)
  static const Color green = Color(0xFF27AE60); // Vibrant green
  static const Color lightGreen = Color(0xFF6FCF97); // Light green
  static const Color darkGreen = Color(0xFF219653); // Dark green
  static const Color successGreen = Color(0xFF27AE60); // Success states

  // Grey variations (extended)
  static const Color lightGrey = Color(0xFFE0E0E0); // Light grey
  static const Color lighterGrey = Color(0xFFF5F5F5); // Very light grey
  static const Color mediumGrey = Color(0xFFBDBDBD); // Medium grey
  static const Color darkGrey = Color(0xFF616161); // Dark grey

  // Status colors
  static const Color yellow = Color(0xFFF2C94C); // Warning
  static const Color orange = Color(0xFFF2994A); // Alert
  static const Color blue = Color(0xFF2F80ED); // Info
  static const Color purple = Color(0xFF9B51E0); // Special

  // Background colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color cardBackground = lightWhite;
  static const Color scaffoldBackground = Color(0xFFF8F9FA);

  // Text colors
  static const Color textPrimary = black;
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
  static const Color textDisabled = Color(0xFFCCCCCC);
  static const Color textOnRed = white;
  static const Color textOnDark = white;

  // Border colors
  static const Color border = Color(0xFFE8E8E8);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color borderDark = Color(0xFFD0D0D0);

  // Shadow colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowDark = Color(0x33000000);

  // Semantic colors
  static const Color error = Color(0xFFEB5757);
  static const Color warning = yellow;
  static const Color info = blue;
  static const Color success = green;

  // Overlay colors
  static const Color overlay = Color(0x66000000);
  static const Color overlayLight = Color(0x33000000);
  static const Color overlayDark = Color(0x99000000);

  // Transparent
  static const Color transparent = Color(0x00000000);

  // Gradients
  static const LinearGradient redGradient = LinearGradient(
    colors: [red, darkRed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [green, darkGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient whiteGradient = LinearGradient(
    colors: [lightWhite, white],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Specific UI colors
  static const Color appBarBackground = lightWhite;
  static const Color bottomNavBar = lightWhite;
  static const Color floatingActionButton = red;
  static const Color tabBarSelected = red;
  static const Color tabBarUnselected = grey;

  // Food-related colors
  static const Color pizzaCrust = Color(0xFFF7B500);
  static const Color cheese = Color(0xFFFFD700);
  static const Color tomato = Color(0xFFE74C3C);
  static const Color basil = Color(0xFF27AE60);
  static const Color dough = Color(0xFFF1ECE7);

  // Order status colors
  static const Color statusPending = Color(0xFFFFA726);
  static const Color statusPreparing = Color(0xFF29B6F6);
  static const Color statusReady = Color(0xFF66BB6A);
  static const Color statusDelivered = Color(0xFF78909C);
  static const Color statusCancelled = Color(0xFFEF5350);

  // Helper methods
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  static Color lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }

  // Material color swatches
  static const MaterialColor redSwatch = MaterialColor(
    0xFFD81B32,
    <int, Color>{
      50: Color(0xFFFBEBEC),
      100: Color(0xFFF5CCD0),
      200: Color(0xFFEEAAAF),
      300: Color(0xFFE7878E),
      400: Color(0xFFE16D76),
      500: Color(0xFFDC525E),
      600: Color(0xFFD84B56),
      700: Color(0xFFD3414C),
      800: Color(0xFFCE3842),
      900: Color(0xFFC52831),
    },
  );

  static const MaterialColor greenSwatch = MaterialColor(
    0xFF27AE60,
    <int, Color>{
      50: Color(0xFFE8F5E9),
      100: Color(0xFFC8E6C9),
      200: Color(0xFFA5D6A7),
      300: Color(0xFF81C784),
      400: Color(0xFF66BB6A),
      500: Color(0xFF4CAF50),
      600: Color(0xFF43A047),
      700: Color(0xFF388E3C),
      800: Color(0xFF2E7D32),
      900: Color(0xFF1B5E20),
    },
  );
}
