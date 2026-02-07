// ignore_for_file: depend_on_referenced_packages
import 'package:carwan_dough/models/user_model.dart';
import 'package:carwan_dough/services/auth_services.dart';
import 'package:carwan_dough/utils/app_constant.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authServices) : super(AuthInitial()) {
    checkAuth();
  }
  final AuthServices authServices;
  late final UserModel _user;
  UserModel get user => _user;

  Future<void> checkAuth() async {
    emit(AuthLoading());
    try {
      final user = await authServices.getUser(); // now guaranteed to return valid UserModel
      _user = user; // this is no longer null
      debugPrint("_uid: ${_user.uid} && _role: ${_user.role.name}");
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      debugPrint("Auth check failed: $e");
      emit(AuthUnauthenticated("Un authenticated"));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading()); //Todo: print status
    try {
      await authServices.login(email, password);
      emit(AuthAuthenticated(user: user));
    } catch (error) {
      emit(AuthUnauthenticated(parseError(error)));
    }
  }

  Future<void> register(UserModel user) async {
    emit(AuthLoading());
    try {
      await authServices.register(user);
      emit(AuthAuthenticated());
    } catch (error) {
      emit(AuthUnauthenticated(parseError(error)));
    }
  }
}
