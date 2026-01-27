import 'package:carwan_dough/utils/helper/error_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

String generateId() => DateTime.now().toIso8601String();

String parseError(Object error) {
  if (error is FirebaseAuthException) {
    return FirebaseAuthErrorMapper.message(error);
  }
  if (error is FirebaseException) {
    return FirestoreErrorMapper.message(error);
  }
  return error.toString();
}
