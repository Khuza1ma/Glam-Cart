import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import '../controllers/setting_controller.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [Center(child: Text('Home'))],
          ),
        ),
      ),
    );
  }
}
