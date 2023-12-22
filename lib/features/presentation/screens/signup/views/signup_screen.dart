import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'package:glam_cart/core/constants/app_images.dart';
import 'package:glam_cart/features/presentation/screens/signup/controllers/signup_controller.dart';
import 'package:glam_cart/features/presentation/widgets/app_textfield.dart';
import 'package:glam_cart/features/presentation/widgets/main_button.dart';
import 'package:glam_cart/features/presentation/widgets/widget_ext.dart';
import 'package:glam_cart/features/routes/app_pages.dart';

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Obx(() => FormBuilder(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create an \naccount',
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
                      controller: controller.passwordController,
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
                              !controller.isPasswordVisible();
                        },
                        icon: Icon(
                          controller.isPasswordVisible()
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
                    30.verticalSpace,
                    AppTextFormField(
                      name: 'confirmPassword',
                      hintText: 'ConfirmPassword',
                      hasBorder: true,
                      controller: controller.confirmPasswordController,
                      isObscure: controller.isConfirmPasswordVisible.value,
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
                          controller.isConfirmPasswordVisible.value =
                              !controller.isConfirmPasswordVisible();
                        },
                        icon: Icon(
                          controller.isConfirmPasswordVisible()
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.k626262,
                        ),
                      ),
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter confirm password';
                        } else if (controller.passwordController.text.trim() !=
                            controller.confirmPasswordController.text.trim()) {
                          return 'Password did not matched';
                        }
                        return null;
                      },
                    ),
                    20.verticalSpace,
                    RichText(
                      text: const TextSpan(
                        text: 'By clicking the ',
                        style: TextStyle(
                          color: AppColors.k676767,
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'Register ',
                            style: TextStyle(
                              color: AppColors.kFF4B26,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'button, you agree \nto the public offer',
                            style: TextStyle(
                              color: AppColors.k676767,
                              fontSize: 12,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    40.verticalSpace,
                    MainButton(
                      onPressed: () {
                        if (controller.formKey.currentState?.validate() ??
                            false) {
                          controller.createAccount();
                          Get.offAndToNamed(Routes.home);
                        }
                      },
                      isLoading: controller.isLoading.value,
                      text: 'Create Account',
                    ),
                    40.verticalSpace,
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
                        Get.offAndToNamed(Routes.login);
                      },
                      child: Center(
                        child: RichText(
                          text: const TextSpan(
                            text: 'I Already Have an Account',
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
                                text: 'Login',
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
              )),
        ),
      ),
    );
  }
}
