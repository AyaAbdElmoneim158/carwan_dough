import 'dart:math';

import 'package:carwan_dough/app_navigation_bar.dart';
import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/utils/theme/app_colors.dart';
import 'package:carwan_dough/views/pages/home_page.dart';
import 'package:carwan_dough/views/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/logo.png",
                height: size.height * 0.08,
              ),
            ),
            // ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 420, // 👈 limits width on tablets/web
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    //Todo:  boxShadow:
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // spacing: 16,
                      children: [
                        Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: AppColors.red,
                              ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          height: 42,
                          child: TextFormField(
                            controller: emailController,
                            validator: (val) => (val == null || val.isEmpty) ? "Enter your email,please...!" : null, //Todo: file validation

                            decoration: InputDecoration(labelText: "Email"),
                          ),
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          height: 42,
                          child: TextFormField(
                            controller: passwordController,
                            validator: (val) => (val == null || val.isEmpty) ? "Enter your password,please...!" : null, //Todo: file validation
                            //Todo: eye
                            decoration: InputDecoration(labelText: "Password"),
                          ),
                        ),
                        SizedBox(height: 12),
                        BlocConsumer<AuthCubit, AuthState>(
                          //Todo: listenWhen: (previous, current) => ,
                          //Todo:  buildWhen: (previous, current) => ,
                          listener: (context, state) {
                            if (state is AuthError) {
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                              showDialog(
                                //Todo: like
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Error'),
                                  content: Text(state.error),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else if (state is AuthLoaded) {
                              Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute<void>(
                                  builder: (context) => const AppNavigationBar(),
                                ),
                              );
                            }
                          },

                          builder: (context, state) {
                            return SizedBox(
                              height: 42,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: (state is AuthLoading)
                                    ? null
                                    : () async {
                                        if (formKey.currentState!.validate()) {
                                          await context.read<AuthCubit>().login(
                                                emailController.text,
                                                passwordController.text,
                                              );
                                        }
                                      },
                                child: (state is AuthLoading) ? CupertinoActivityIndicator() : Text("Login"),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Forget password?",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                color: AppColors.red,
                                fontWeight: FontWeight.w500,
                                // fontFamily: "Montserrat",
                              ),
                        ),
                        SizedBox(height: 4),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute<void>(
                                builder: (context) => const SignupPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Or Signup",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  color: AppColors.red,
                                  fontWeight: FontWeight.w500,
                                  // fontFamily: "Montserrat",
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
