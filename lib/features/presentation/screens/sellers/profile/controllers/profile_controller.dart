import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

}
