import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/presentation/screens/users/cart/controllers/cart_controller.dart';
import 'package:glam_cart/features/presentation/screens/users/home/controllers/home_controller.dart';
import 'package:glam_cart/features/presentation/screens/users/setting/controllers/setting_controller.dart';
import 'package:glam_cart/features/presentation/screens/users/wishlist/controllers/wishlist_controller.dart';
import 'package:glam_cart/features/presentation/screens/users/wishlist/views/wishlist_screen.dart';
import '../../cart/views/cart_screen.dart';
import '../../home/views/home_screen.dart';
import '../../search/views/search_screen.dart';
import '../../setting/views/setting_screen.dart';

class NavigationController extends GetxController {
  RxInt selectedIndex = 0.obs;
  final List<Widget> screens = [
    const HomeScreen(),
    const WishListScreen(),
    const CartScreen(),
    const SearchScreen(),
    const SettingScreen(),
  ];

  @override
  void onInit() {
    Get.put(HomeController());
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
