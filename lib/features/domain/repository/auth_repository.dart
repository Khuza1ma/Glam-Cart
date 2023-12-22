import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required bool isAdmin,
  }) async {
    try {
      var response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        var user = response.user!;
        UserModel userData = UserModel(
          email: email,
          name: user.displayName ?? '',
          uid: user.uid,
          isAdmin: isAdmin,
        );
        if (isAdmin) {
          await FirebaseFirestore.instance
              .collection('/sellers')
              .doc(user.uid)
              .set(userData.toMap());
        } else {
          await FirebaseFirestore.instance
              .collection('/users')
              .doc(user.uid)
              .set(userData.toMap());
        }

        return userData;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<FirebaseAuthResult> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
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
