import 'package:carwan_dough/models/user_model.dart';
import 'package:carwan_dough/utils/helper/auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<User?> register(UserModel user);
  Future<User?> login(String email, String password);
}

class AuthServicesImpl implements AuthServices {
  final AuthHelper authHelper = AuthHelperImpl(); //Todo: di_get.it

  @override
  Future<User?> login(String email, String password) async {
    return await authHelper.login(email, password);
  }

  @override
  Future<User?> register(UserModel user) async {
    return await authHelper.register(user);
  }
}
