import 'package:carwan_dough/models/user_model.dart';
import 'package:carwan_dough/utils/api_path.dart';
import 'package:carwan_dough/utils/helper/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthHelper {
  Future<User?> register(UserModel user);
  Future<User?> login(String email, String password);
  Future<void> logout();
  User? getCurrentUser();
  Stream<User?> authStateChanges();

  Future<void> sendPasswordResetEmail(String email);
  Future<void> updatePassword(String newPassword);
}

class AuthHelperImpl implements AuthHelper {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirestoreHelper.instance;

  @override
  Future<User?> register(UserModel user) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email.trim(),
      password: user.password.trim(),
    );
    await _saveUser(user.copyWith(uid: userCredential.user!.uid));
    return userCredential.user;
  }

  Future<void> _saveUser(UserModel user) async {
    await _firestore.setData(
      path: ApiPath.users(user.uid),
      data: user.toMap(),
    );
  }

  @override
  Future<User?> login(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    return userCredential.user;
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  User? getCurrentUser() => _firebaseAuth.currentUser;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    final user = getCurrentUser();
    if (user != null) {
      await user.updatePassword(newPassword.trim());
    } else {
      throw FirebaseAuthException(
        code: 'no-user',
        message: 'No user is currently signed in',
      );
    }
  }
}
