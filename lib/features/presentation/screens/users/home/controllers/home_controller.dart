import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/domain/repository/auth_repository.dart';
import '../../../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final pageController = PageController(
    viewportFraction: 1.0,
    keepPage: true,
  );

  Future<void> logoutUser() async {
    try {
      await AuthRepository(firebaseAuth: _auth).logOut();
      Get.offAllNamed(Routes.login);
    } catch (e) {
      print('Logout Error: $e');
    }
  }
}
