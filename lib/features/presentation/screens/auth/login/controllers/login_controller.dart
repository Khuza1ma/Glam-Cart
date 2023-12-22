import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../../domain/repository/auth_repository.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future logInToAccount() async {
    try {
      isLoading.value = true;
      if (formKey.currentState?.saveAndValidate() ?? false) {
        var formData = formKey.currentState?.value;
        final email = formData!['username'];
        final password = formData!['password'];
        print('User:::$email');
        print('Pass:::$password');
        await AuthRepository(firebaseAuth: _auth).logIn(
          email: email,
          password: password,
        );
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
    }
  }
}
