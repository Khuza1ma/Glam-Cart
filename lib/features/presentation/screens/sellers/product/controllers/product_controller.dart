import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/config/app_colors.dart';

class ProductController extends GetxController {
  RxBool isLoading = false.obs;
  final int minImages = 3;
  RxList<Widget> imageContainers = <Widget>[].obs;
  List<File> selectedImages = [];
  final Rx<String> selectedValue = 'Man'.obs;
  final RxList<String> items = ['Man', 'Woman', 'Unisex'].obs;

  @override
  void onInit() {
    super.onInit();
    imageContainers(
      List.generate(
        minImages,
        (index) => buildImageUploadContainer(index),
      ),
    );
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
}
