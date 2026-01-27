// ignore_for_file: depend_on_referenced_packages
import 'package:carwan_dough/models/user_model.dart';
import 'package:carwan_dough/services/auth_services.dart';
import 'package:carwan_dough/utils/helper/function_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthServices authServices = AuthServicesImpl(); //Todo: di_get.it

  Future<void> login(String email, String password) async {
    emit(AuthLoading()); //Todo: print status
    print("AuthLoading");
    try {
      await authServices.login(email, password);
      emit(AuthLoaded());
      print("AuthLoaded");
    } catch (error) {
      emit(AuthError(parseError(error)));
      print("AuthError");
    }
  }

  Future<void> register(UserModel user) async {
    emit(AuthLoading());
    try {
      await authServices.register(user);
      emit(AuthLoaded());
    } catch (error) {
      emit(AuthError(parseError(error)));
    }
  }
}
