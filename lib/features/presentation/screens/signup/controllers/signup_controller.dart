import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/domain/repository/auth_repository.dart';

class SignupController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createAccount() async {
    try {
      isLoading.value = true;
      if (formKey.currentState?.saveAndValidate() ?? false) {
        var formData = formKey.currentState?.value;
        final email = formData!['username'];
        final password = formData!['password'];
        print('User:::$email');
        print('Pass:::$password');
        await AuthRepository(firebaseAuth: _auth).signUp(
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
