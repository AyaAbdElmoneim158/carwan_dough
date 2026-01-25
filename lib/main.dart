import 'dart:math';

import 'package:carwan_dough/app_colors.dart';
import 'package:carwan_dough/home_page.dart';
import 'package:carwan_dough/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "NaughtyMonster",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: AppColors.grey, fontFamily: "Montserrat"),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkRed),
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
              textStyle: TextStyle(fontFamily: "Montserrat")),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
