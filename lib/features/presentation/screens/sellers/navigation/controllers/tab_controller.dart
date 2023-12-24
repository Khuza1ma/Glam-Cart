import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/presentation/screens/sellers/dashboard/controllers/dashboard_controller.dart';
import 'package:glam_cart/features/presentation/screens/sellers/dashboard/views/dashboard_screen.dart';
import 'package:glam_cart/features/presentation/screens/users/cart/controllers/cart_controller.dart';
import 'package:glam_cart/features/presentation/screens/users/home/controllers/home_controller.dart';
import 'package:glam_cart/features/presentation/screens/users/setting/controllers/setting_controller.dart';
import 'package:glam_cart/features/presentation/screens/users/wishlist/controllers/wishlist_controller.dart';

class TabsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final List<Widget> screens = [
    const DashboardScreen(),
    // const StoreScreen(),
    // const SetupScreen(),
    // const SetupScreen(),

  ];

  @override
  void onInit() {
    Get.put(DashboardController());
    super.onInit();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    if (index == 0){
      Get.put(HomeController());
    } else if (index == 1) {
      Get.put(WishListController());
    } else if (index == 2) {
      Get.put(CartController());
    } else if (index == 3) {
      Get.put(SearchController());
    }else if (index == 4) {
      Get.put(SettingController());
    }
  }
}
