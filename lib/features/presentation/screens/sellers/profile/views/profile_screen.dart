import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'package:glam_cart/core/constants/app_images.dart';
import 'package:glam_cart/features/presentation/widgets/app_textfield.dart';
import 'package:glam_cart/features/presentation/widgets/main_button.dart';
import 'package:glam_cart/features/presentation/widgets/widget_ext.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  AppAssets.facebook,
                  height: 100,
                  width: 100,
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
                onPressed: () {},
                text: 'Save',
                hasBottomMargin: false,
                borderRadius: BorderRadius.circular(8),
              )
            ],
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
        ),
        _buildTextField(
          name: 'sellerName',
          hintText: 'Name',
          label: 'Seller Name',
        ),
        _buildTextField(
          name: 'familyName',
          hintText: 'Family Name',
          label: 'Family Name',
        ),
        _buildTextField(
          name: 'Contact',
          hintText: 'contact',
          label: 'contact',
          textInputType: TextInputType.phone,
        ),
        _buildTextField(
          name: 'address',
          hintText: 'Address',
          label: 'Address',
          maxLines: 3,
        ),
        _buildTextField(
          name: 'state',
          hintText: 'State',
          label: 'State',
        ),
        _buildTextField(
          name: 'city',
          hintText: 'City',
          label: 'City',
        ),
        _buildTextField(
          name: 'pincode',
          hintText: 'Pincode',
          label: 'Pincode',
          textInputType: TextInputType.number,
        ),
      ],
    );
  }

  Column _buildTextField({
    required String label,
    required String name,
    required String hintText,
    int maxLines = 1,
    TextInputType textInputType=TextInputType.text
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
      ),
      20.verticalSpace,
    ]);
  }
}
