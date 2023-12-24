
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/domain/repository/auth_repository.dart';

import '../../../../../data/models/user_model.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  var isAdmin = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    // Listen to the auth state changes.
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      isAuthenticated.value = user != null;
      if (user != null) {
        // Call fetchUserModel and await its result using a Future.
        Future.delayed(Duration.zero, () async {
          UserModel? userModel = await AuthRepository(firebaseAuth: _auth).fetchUserModel(user.uid);
          isAdmin.value = userModel?.isAdmin ?? false;
        });
      } else {
        isAdmin.value = false;
      }
    });
  }





}
