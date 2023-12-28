import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/data/models/user_model.dart';
import '../../../../../data/models/seller_model.dart';
import '../../../../../domain/repository/seller_repository.dart';
import 'package:file_picker/file_picker.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserModel userModel;
  Uint8List? fileBytes;
  Rx<File?> pickedImageFile = Rx<File?>(null);
  Rxn<Seller> sellerData = Rxn<Seller>();

  @override
  Future<void> onInit() async {
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
    await getSeller();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      fileBytes = await file.readAsBytes();
      pickedImageFile.value = file;
    } else {
      // User canceled the picker
    }
  }

  Future<void> saveSeller() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      isLoading.value = true;

      try {
        var originalFormData = formKey.currentState?.value;
        print("Form data: $originalFormData");

        if (originalFormData == null || fileBytes == null) {
          throw Exception("Form data or file is null");
        }

        var formData = Map<String, dynamic>.from(originalFormData);
        formData['fileBytes'] = fileBytes;

        Seller seller = Seller.fromMap(formData);

        if (fileBytes != null) {
          await SellerRepository()
              .saveSeller(seller, userModel.uid, fileBytes!);

          isLoading.value = false;
          Get.snackbar("Success", "Seller information saved successfully");
        } else {
          Get.snackbar(
            "Failed",
            "Please upload an image",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Error", "Failed to save seller information: $e");
        print("Error: $e");
      }
    } else {
      Get.snackbar("Error", "Validation failed. Please check your input.");
    }
  }

  Future<void> getSeller() async {
    isLoading.value = true;
    try {
      var currentUser = _auth.currentUser;
      if (currentUser != null) {
        Seller seller = await SellerRepository().getSeller(currentUser.uid);
        sellerData.value = seller;
      } else {
        throw Exception("No current user found");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch seller information: $e");
      print("Error: $e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
