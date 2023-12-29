import 'dart:io';
import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/domain/repository/product_repository.dart';
import '../../../../../../core/config/app_colors.dart';
import '../../../../../data/models/product_model.dart';
import '../../../../../data/models/user_model.dart';

class ProductController extends GetxController {
  RxBool isLoading = false.obs;
  final int minImages = 3;
  RxList<Widget> imageContainers = <Widget>[].obs;
  List<File> selectedImages = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late UserModel userModel;
  final Rx<String> selectedCategory = 'Men'.obs;
  final RxList<String> items = ['Men', 'Women', 'Unisex'].obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  void onInit() {
    super.onInit();
    imageContainers(
      List.generate(
        minImages,
        (index) => buildImageUploadContainer(index),
      ),
    );
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

  Widget buildImageUploadContainer(int index) {
    return index == 0 ? buildInitialUploadContainer() : buildEmptyContainer();
  }

  Future pickImage(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      if (index < selectedImages.length) {
        selectedImages[index] = file;
      } else {
        selectedImages.add(file);
      }
      updateImageContainers();
    }
  }

  void updateImageContainers() {
    imageContainers(
      List.generate(
        minImages,
        (index) {
          return index < selectedImages.length
              ? buildSelectedImageContainer(selectedImages[index])
              : buildImageUploadContainer(index);
        },
      ),
    );
    update();
  }

  Widget buildSelectedImageContainer(File image) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Image.file(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildInitialUploadContainer() {
    return SizedBox(
      height: 150,
      width: 150,
      child: DottedBorder(
        stackFit: StackFit.expand,
        color: AppColors.k000000.withOpacity(0.50),
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [10, 8],
        strokeWidth: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_outlined,
              color: AppColors.k000000.withOpacity(0.30),
            ),
            Text(
              'Click here to add\nproduct image',
              style: TextStyle(
                color: AppColors.k000000.withOpacity(0.30),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildEmptyContainer() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.k000000.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  List<Widget> getImageContainers() {
    return imageContainers;
  }

  Future<void> saveProduct() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      isLoading(true);
      try {
        final formData = formKey.currentState?.value;
        String productName = formData!['productName'];
        String description = formData['description'];
        String price = formData['price'];

        List<Uint8List> imageBytesList = [];
        for (File image in selectedImages) {
          Uint8List imageBytes = await image.readAsBytes();
          imageBytesList.add(imageBytes);
        }
        var currentUser = _auth.currentUser;
        Product product = Product(
          productName: productName,
          description: description,
          productImages: [],
          price: price,
          category: selectedCategory.value,
        );

        await ProductRepository()
            .saveProduct(product, currentUser!.uid, imageBytesList);

        Get.snackbar("Success", "Product saved successfully");
      } catch (e) {
        Get.snackbar("Error", "Failed to save product: ${e.toString()}");
      } finally {
        isLoading(false);
      }
    }
  }
}
