import 'package:carwan_dough/models/user_model.dart';
import 'package:carwan_dough/utils/api_path.dart';
import 'package:carwan_dough/utils/helper/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static final instance = AuthHelper._();
  final _firebaseAuth = FirebaseAuth.instance;

  final firestoreHelper = FirestoreHelper.instance;
  Future<User?> register(UserModel user) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email.trim(),
      password: user.password.trim(),
    );
    await _saveUser(user.copyWith(uid: userCredential.user!.uid));
    return userCredential.user;
  }

  Future<void> _saveUser(UserModel user) async {
    await firestoreHelper.setData(
      path: ApiPath.users(user.uid),
      data: user.toMap(),
    );
  }

  Future<User?> login(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    return userCredential.user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> updatePassword(String newPassword) async {
    final user = getCurrentUser();
    await user?.updatePassword(newPassword.trim());
  }
}
