import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../domain/repository/auth_repository.dart';
import '../../../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logInToAccount() async {
    try {
      isLoading.value = true;
      if (formKey.currentState?.saveAndValidate() ?? false) {
        var formData = formKey.currentState?.value;
        final email = formData!['username'];
        final password = formData['password'];

        FirebaseAuthResult result =
            await AuthRepository(firebaseAuth: _auth).logIn(
          email: email,
          password: password,
        );

        isLoading.value = false;

        if (result.success) {
          Get.offAllNamed(Routes.navigation);
        } else {
          if (result.errorCode == 'user-not-found' ||
              result.errorCode == 'wrong-password') {
            Get.snackbar(
              'Login Failed',
              'Invalid email or password.',
              snackPosition: SnackPosition.BOTTOM,
            );
          } else {
            Get.snackbar(
              'Login Failed',
              result.errorMessage ?? 'Some Error Occurred',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
      Get.snackbar(
        'Error',
        'An unexpected error occurred.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
