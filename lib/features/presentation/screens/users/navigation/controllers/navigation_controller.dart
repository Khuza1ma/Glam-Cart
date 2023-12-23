import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
