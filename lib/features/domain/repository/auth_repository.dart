import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  Future<FirebaseAuthResult> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return FirebaseAuthResult(success: true);
    } on FirebaseAuthException catch (e) {
      return FirebaseAuthResult(
        success: false,
        errorCode: e.code,
      );
    }
  }
}

class FirebaseAuthResult {
  final bool success;
  final String? errorCode;

  FirebaseAuthResult({
    required this.success,
    this.errorCode,
  });
}
