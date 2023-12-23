import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/data/models/user_model.dart';
import 'package:glam_cart/features/domain/repository/auth_repository.dart';

class SignupController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;
  RxBool isConfirmPasswordVisible = true.obs;
  RxBool isAdminAccount = false.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<UserModel?> user = Rx<UserModel?>(null);

  Future createAccount() async {
    try {
      isLoading.value = true;
      if (formKey.currentState?.saveAndValidate() ?? false) {
        var formData = formKey.currentState?.value;
        final email = formData!['username'];
        final password = formData['password'];
        print('User:::$email');
        print('Pass:::$password');

        UserModel? userData = await AuthRepository(firebaseAuth: _auth).signUp(
          email: email,
          password: password,
          isAdmin: isAdminAccount.value,
        );
        if (userData != null) {
          user.value = userData;
        } else {
          print('Some Error occurred');
        }
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

}
