import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'package:glam_cart/core/constants/app_images.dart';
import 'package:glam_cart/features/presentation/widgets/app_textfield.dart';
import 'package:glam_cart/features/presentation/widgets/main_button.dart';
import 'package:glam_cart/features/presentation/widgets/widget_ext.dart';
import 'package:glam_cart/features/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Obx(
            () => FormBuilder(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome \nBack!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  35.verticalSpace,
                  AppTextFormField(
                    name: 'username',
                    hintText: 'Username or Email',
                    hasBorder: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    preFixIcon: Image.asset(AppAssets.username),
                    validate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a email';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  30.verticalSpace,
                  AppTextFormField(
                    name: 'password',
                    hintText: 'Password',
                    hasBorder: true,
                    isObscure: controller.isPasswordVisible.value,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    preFixIcon: IconButton(
                      onPressed: null,
                      icon: Image.asset(
                        AppAssets.password,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    suffixIcon: IconButton(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        controller.isPasswordVisible.value =
                            !controller.isPasswordVisible.value;
                      },
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.k626262,
                      ),
                    ),
                    validate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a password';
                      } else if (value.trim().length < 8) {
                        return 'Password must contain at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  10.verticalSpace,
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.kF83758,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  50.verticalSpace,
                  MainButton(
                    onPressed: () {
                      if (controller.formKey.currentState?.validate() ??
                          false) {
                        controller.logInToAccount();
                        Get.offAndToNamed(Routes.navigation);
                      }
                    },
                    isLoading: controller.isLoading.value,
                    text: 'Login',
                  ),
                  70.verticalSpace,
                  const Center(
                    child: Text(
                      '- OR Continue with -',
                      style: TextStyle(
                        color: AppColors.k575757,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: AppColors.kFBF3F5,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: AppColors.kF73658),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Image.asset(
                            AppAssets.google,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      SvgPicture.asset(AppAssets.apple),
                      10.horizontalSpace,
                      SvgPicture.asset(AppAssets.facebook),
                    ],
                  ),
                  30.verticalSpace,
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Get.offAndToNamed(Routes.signup);
                    },
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                          text: 'Create An Account',
                          style: TextStyle(
                            color: Color(0xFF575757),
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: SizedBox(width: 5),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Color(0xFFF73658),
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
