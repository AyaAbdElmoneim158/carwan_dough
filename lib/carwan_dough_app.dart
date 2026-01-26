import 'package:carwan_dough/app_navigation_bar.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CarwanDoughApp extends StatelessWidget {
  const CarwanDoughApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstant.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: AppNavigationBar(),
      // home: const HomePage(),
      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
