import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/presentation/widgets/widget_ext.dart';
import 'package:glam_cart/features/routes/app_pages.dart';
import '../../../../../../core/config/app_colors.dart';
import '../../../../../../core/constants/app_images.dart';
import '../../../../widgets/main_button.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

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
                buildDetailsView(),
                30.verticalSpace,
                MainButton(
                  onPressed: () {
                    Get.offAndToNamed(Routes.editProfile);
                  },
                  text: 'Edit Profile',
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

  Column buildDetailsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleValue(
          title: 'Email',
          value: 'email.com',
        ),
        20.verticalSpace,
        buildTitleValue(
          title: 'Seller Name',
          value: 'email.com',
        ),
        20.verticalSpace,
        buildTitleValue(
          title: 'Family Name',
          value: 'email.com',
        ),
        20.verticalSpace,
        buildTitleValue(
          title: 'Contact',
          value: 'email.com',
        ),
        20.verticalSpace,
        buildTitleValue(
          title: 'Address',
          value: 'email.com',
        ),
        20.verticalSpace,
        buildTitleValue(
          title: 'State',
          value: 'email.com',
        ),
        20.verticalSpace,
        buildTitleValue(
          title: 'City',
          value: 'email.com',
        ),
        20.verticalSpace,
        buildTitleValue(
          title: 'Pincode',
          value: 'email.com',
        ),
      ],
    );
  }

  Widget buildTitleValue({
    required String title,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        text: '$title :',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.k000000,
          fontSize: 16,
        ),
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.k000000,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
