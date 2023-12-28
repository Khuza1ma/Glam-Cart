import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import '../controllers/tab_controller.dart';

class TabScreen extends GetView<TabsController> {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kF5F5F5,
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.screens,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
        ),
        child: Obx(
          () => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.feedback_outlined),
                label: 'Store',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  width: 55,
                  height: 55,
                  decoration: ShapeDecoration(
                    color: controller.selectedIndex.value == 2
                        ? AppColors.kF83758
                        : AppColors.kFFFFFF,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  duration: const Duration(milliseconds: 250),
                  child: const Icon(Icons.store_mall_directory_outlined),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.deck),
                label: 'Deciding',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: 'Profile',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            unselectedItemColor: AppColors.k000000,
            selectedItemColor: controller.selectedIndex.value == 2
                ? AppColors.kFFFFFF
                : AppColors.kF83758,
            selectedIconTheme: IconThemeData(
              color: controller.selectedIndex.value == 2
                  ? AppColors.kFFFFFF
                  : AppColors.kF83758,
            ),
            onTap: controller.changeIndex,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}
