import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/data/models/user_model.dart';
import 'package:glam_cart/features/domain/repository/auth_repository.dart';

import '../../../../../routes/app_pages.dart';

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

  Future<void> createAccount() async {
    try {
      isLoading.value = true;
      if (formKey.currentState?.saveAndValidate() ?? false) {
        var formData = formKey.currentState?.value;
        final email = formData!['username'];
        final password = formData['password'];

        UserModel? userData = await AuthRepository(firebaseAuth: _auth).signUp(
          email: email,
          password: password,
          isAdmin: isAdminAccount.value,
        );

        isLoading.value = false;

        if (userData != null) {
          user.value = userData;
          if (userData.isAdmin) {
            Get.offAllNamed(Routes.tab);
          } else {
            Get.offAllNamed(Routes.navigation);
          }
        } else {
          print('User creation failed');
        }
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print('Error creating account: $e');
    }
  }


}
