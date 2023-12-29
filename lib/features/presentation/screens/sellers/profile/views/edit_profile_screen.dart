import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'package:glam_cart/core/constants/app_images.dart';
import 'package:glam_cart/features/presentation/widgets/app_textfield.dart';
import 'package:glam_cart/features/presentation/widgets/main_button.dart';
import 'package:glam_cart/features/presentation/widgets/widget_ext.dart';
import '../controllers/profile_controller.dart';

class EditProfileScreen extends GetView<ProfileController> {
  EditProfileScreen({super.key});
  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: FormBuilder(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Obx(
                        () {
                          return CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.kFFFFFF,
                            backgroundImage: controller.pickedImageFile.value !=
                                    null
                                ? FileImage(controller.pickedImageFile.value!)
                                : AssetImage(AppAssets.profile)
                                    as ImageProvider,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.pickFile();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.k000000,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: AppColors.kFFFFFF,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                25.verticalSpace,
                const Text(
                  'Personal Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.verticalSpace,
                _buildForm(),
                10.verticalSpace,
                MainButton(
                  onPressed: () async {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      await controller.saveSeller();
                      Get.snackbar(
                        'Successful',
                        'successful',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  text: 'Save',
                  isLoading: controller.isLoading.value,
                  hasBottomMargin: false,
                  borderRadius: BorderRadius.circular(8),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildForm() {
    return Column(
      children: [
        _buildTextField(
          name: 'email',
          hintText: 'Email',
          label: 'Email Address',
          validate: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a email';
            } else if (!GetUtils.isEmail(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        _buildTextField(
          name: 'sellerName',
          hintText: 'Name',
          label: 'Seller Name',
          validate: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter name';
            }
            return null;
          },
        ),
        _buildTextField(
          name: 'familyName',
          hintText: 'Family Name',
          label: 'Family Name',
          validate: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter family name';
            }
            return null;
          },
        ),
        _buildTextField(
          name: 'contact',
          hintText: 'Contact',
          label: 'Contact',
          textInputType: TextInputType.phone,
          validate: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter contact';
            } else if (value.length < 10 || value.length > 10) {
              return 'Please enter a valid contact';
            }
            return null;
          },
        ),
        _buildTextField(
          name: 'address',
          hintText: 'Address',
          label: 'Address',
          maxLines: 3,
          validate: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter Address';
            }
            return null;
          },
        ),
        _buildTextField(
          name: 'state',
          hintText: 'State',
          label: 'State',
          validate: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter state';
            }
            return null;
          },
        ),
        _buildTextField(
          name: 'city',
          hintText: 'City',
          label: 'City',
          validate: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter city';
            }
            return null;
          },
        ),
        _buildTextField(
          name: 'pincode',
          hintText: 'Pincode',
          label: 'Pincode',
          textInputType: TextInputType.number,
          validate: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a pincode';
            } else if (value.length < 6 || value.length > 6) {
              return 'Please enter a valid pincode';
            }
            return null;
          },
        ),
      ],
    );
  }

  Column _buildTextField({
    required String label,
    required String name,
    required String hintText,
    int maxLines = 1,
    TextInputType textInputType = TextInputType.text,
    required String? Function(dynamic)? validate,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        label,
        style: const TextStyle(
          color: AppColors.k000000,
          fontSize: 12,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w400,
        ),
      ),
      10.verticalSpace,
      AppTextFormField(
        name: name,
        hintText: hintText,
        maxLines: maxLines,
        keyboardType: textInputType,
        hintStyle: const TextStyle(
          color: AppColors.kC7C7C7,
        ),
        hasBorder: true,
        borderColor: AppColors.kC7C7C7,
        fillColor: AppColors.kFFFFFF,
        validate: validate,
      ),
      20.verticalSpace,
    ]);
  }
}
