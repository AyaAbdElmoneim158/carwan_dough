import 'package:carwan_dough/carwan_dough_app.dart';
import 'package:carwan_dough/controllers/auth/auth_cubit.dart';
import 'package:carwan_dough/firebase_options.dart';
import 'package:carwan_dough/services/auth_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Todo: just pretrial | issue page.view
  runApp(
    BlocProvider(
      create: (_) => AuthCubit(AuthServicesImpl()),
      child: const CarwanDoughApp(),
    ),
  );
}
// ayhb756@gmail.com  | Aya Abdelmonem | change as admain
