import 'package:carwan_dough/models/user_model.dart';
import 'package:carwan_dough/utils/helper/auth_helper.dart';
import 'package:carwan_dough/utils/helper/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthServices {
  Future<User?> register(UserModel user);
  Future<User?> login(String email, String password);
  Future<UserModel> getUser();
}

class AuthServicesImpl implements AuthServices {
  final AuthHelper authHelper = AuthHelper.instance; //Todo: get.it
  final FirestoreHelper firestoreHelper = FirestoreHelper.instance; //Todo: get.it

  @override
  Future<User?> login(String email, String password) async {
    return await authHelper.login(email, password);
  }

  @override
  Future<User?> register(UserModel user) async {
    return await authHelper.register(user);
  }

  @override
  @override
  Future<UserModel> getUser() async {
    final currentUser = authHelper.getCurrentUser();

    if (currentUser == null) {
      debugPrint("No logged-in user");
      throw Exception("No logged-in user");
    }

    final uid = currentUser.uid;
    debugPrint("uid: $uid");

    final user = await firestoreHelper.getDocument(
      path: "Users/$uid",
      builder: (data, documentID) => UserModel.fromMap(data),
    );

    debugPrint("User document found: $user");

    return user;
  }
}
