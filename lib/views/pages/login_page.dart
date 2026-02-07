import 'dart:math';

import 'package:carwan_dough/role_based_navigation_bar.dart';
import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/views/pages/signup_page.dart';
import 'package:carwan_dough/views/widgets/app_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authCubit = context.read<AuthCubit>();
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          // ✅ Gradient fills full screen
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  transform: const GradientRotation(75 * pi / 180),
                  colors: const [
                    Color(0xFFD81B32),
                    Color(0xFFEB2222),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: MediaQuery.of(context).padding.top + 12,
            // right: 0,
            child: Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.08,
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: AppCard(
                        scrollable: false,
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                "Login",
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: AppColors.red),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: emailController,
                                validator: (val) => val == null || val.isEmpty ? "Enter your email" : null,
                                decoration: const InputDecoration(labelText: "Email"),
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: passwordController,
                                validator: (val) => val == null || val.isEmpty ? "Enter your password" : null,
                                decoration: const InputDecoration(
                                  labelText: "Password",
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 16),
                              BlocConsumer<AuthCubit, AuthState>(
                                listener: (context, state) {
                                  if (state is AuthUnauthenticated) {
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text('Error'),
                                        content: Text(state.error),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else if (state is AuthAuthenticated) {
                                    Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) => RoleBasedNavigationBar(
                                          role: context.read<AuthCubit>().user.role,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  final isLoading = state is AuthLoading;

                                  return SizedBox(
                                    width: double.infinity,
                                    height: 42,
                                    child: ElevatedButton(
                                      onPressed: isLoading
                                          ? null
                                          : () {
                                              if (formKey.currentState!.validate()) {
                                                authCubit.login(
                                                  emailController.text,
                                                  passwordController.text,
                                                );
                                              }
                                            },
                                      child: isLoading ? const CupertinoActivityIndicator() : const Text("Login"),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Forget password?",
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.red),
                              ),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => const SignupPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Or Signup",
                                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
