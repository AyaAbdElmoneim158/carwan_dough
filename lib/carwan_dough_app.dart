import 'package:carwan_dough/role_based_navigation_bar.dart';
import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/services/auth_services.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/theme/app_theme.dart';
import 'package:carwan_dough/views/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarwanDoughApp extends StatelessWidget {
  const CarwanDoughApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return MaterialApp(
          title: AppConstant.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          home: _buildHome(state),
        );
      },
    );
  }

  Widget _buildHome(AuthState state) {
    if (state is AuthLoading || state is AuthInitial) {
      debugPrint("Goto: Landing");
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else if (state is AuthAuthenticated) {
      final user = state.user;
      debugPrint("Navigation Bar.... role: ${user?.role} | phone: ${user?.phone}");
      if (user == null) return const LoginPage();
      return RoleBasedNavigationBar(role: user.role);
    } else {
      debugPrint("Goto: Login");
      return const LoginPage();
    }
  }
}
