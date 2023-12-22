import 'package:get/get.dart';

import '../controllers/wishlist_controller.dart';

class WishListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishListController>(
      () => WishListController(),
    );
  }
}
