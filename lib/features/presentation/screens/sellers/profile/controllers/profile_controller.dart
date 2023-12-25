import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/data/models/user_model.dart';
import '../../../../../data/models/seller_model.dart';
import '../../../../../domain/repository/seller_repository.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserModel userModel; // Declare as late

  @override
  void onInit() {
    super.onInit();
    var currentUser = _auth.currentUser;
    if (currentUser != null) {
      userModel = UserModel(
        uid: currentUser.uid,
        email: currentUser.email ?? '',
        name: currentUser.displayName ?? '',
        isAdmin: false,
      );
    } else {
      userModel = UserModel(uid: '', email: '', name: '', isAdmin: false);
    }
  }

  Future<void> saveSeller() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      isLoading.value = true;

      try {
        var formData = formKey.currentState?.value;
        print("Form data: $formData"); // Debugging line

        if (formData == null) {
          throw Exception("Form data is null");
        }

        Seller seller = Seller.fromMap(formData);

        await SellerRepository().saveSeller(seller, userModel.uid);

        isLoading.value = false;
        Get.snackbar("Success", "Seller information saved successfully");
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Error", "Failed to save seller information: $e");
        print("Error: $e"); // Debugging line
      }
    } else {
      Get.snackbar("Error", "Validation failed. Please check your input.");
    }
  }
}
