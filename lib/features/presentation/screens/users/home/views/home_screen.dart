import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'package:glam_cart/features/presentation/widgets/main_button.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Center(
                child: Text('Home'),
              ),
              MainButton(
                onPressed: () async {
                  await controller.logoutUser();
                },
                text: 'Logout',
              )
            ],
          ),
        ),
      ),
    );
  }
}
