import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPasswordVisible = true.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
}
