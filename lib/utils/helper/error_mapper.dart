import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthErrorMapper {
  static String message(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'no-user':
        return 'No user is currently signed in';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}

class FirestoreErrorMapper {
  static String message(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'unavailable':
        return 'Service is currently unavailable. Please try again later.';
      case 'deadline-exceeded':
        return 'The request took too long. Please try again.';
      case 'not-found':
        return 'Requested document was not found.';
      case 'already-exists':
        return 'This data already exists.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'invalid-argument':
        return 'Invalid data was provided.';
      case 'resource-exhausted':
        return 'Too many requests. Please try again later.';
      case 'aborted':
        return 'Operation aborted. Please retry.';
      case 'data-loss':
        return 'Data corruption detected. Please contact support.';
      default:
        return 'Database error occurred. Please try again.';
    }
  }
}
