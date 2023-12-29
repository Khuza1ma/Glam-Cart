import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/presentation/screens/sellers/dashboard/controllers/dashboard_controller.dart';
import 'package:glam_cart/features/presentation/screens/sellers/dashboard/views/dashboard_screen.dart';
import 'package:glam_cart/features/presentation/screens/sellers/product/controllers/product_controller.dart';
import 'package:glam_cart/features/presentation/screens/sellers/product/views/product_screen.dart';
import 'package:glam_cart/features/presentation/screens/sellers/profile/controllers/profile_controller.dart';
import 'package:glam_cart/features/presentation/screens/sellers/profile/views/edit_profile_screen.dart';
import 'package:glam_cart/features/presentation/screens/sellers/profile/views/profile_screen.dart';
import 'package:glam_cart/features/presentation/screens/sellers/store/controllers/store_controller.dart';
import '../../store/views/store_screen.dart';

class TabsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  late final List<Widget> screens;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => ProfileController());
    screens = [
      const DashboardScreen(),
      const StoreScreen(),
      const ProductScreen(),
      const StoreScreen(),
      _getProfileScreen(),
    ];
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      if (!Get.isRegistered<DashboardController>()) {
        Get.put(DashboardController());
      }
    } else if (index == 1) {
      if (!Get.isRegistered<ProductController>()) {
        Get.put(StoreController());
      }
    } else if (index == 2) {
      if (!Get.isRegistered<StoreController>()) {
        Get.put(ProductController());
      }
    } else if (index == 3) {
      if (!Get.isRegistered<StoreController>()) {
        Get.put(StoreController());
      }
    } else if (index == 4) {
      if (!Get.isRegistered<ProfileController>()) {
        Get.put(ProfileController());
      }
    }
  }

  Widget _getProfileScreen() {
    return Obx(() {
      final profileController = Get.find<ProfileController>();
      return profileController.sellerData()?.address.isEmpty ?? true
          ? EditProfileScreen()
          : const ProfileScreen();
    });
  }
}
