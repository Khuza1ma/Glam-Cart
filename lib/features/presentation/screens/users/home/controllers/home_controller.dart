import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  final pageController = PageController(
    viewportFraction: 1.0,
    keepPage: true,
  );
}
