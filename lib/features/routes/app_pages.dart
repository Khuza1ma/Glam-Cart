import 'package:get/get.dart';
import 'package:glam_cart/features/presentation/screens/sellers/profile/bindings/profile_binding.dart';
import 'package:glam_cart/features/presentation/screens/sellers/profile/views/profile_screen.dart';
import '../presentation/screens/sellers/product/bindings/product_binding.dart';
import '../presentation/screens/sellers/product/views/product_screen.dart';
import '../presentation/screens/sellers/store/bindings/store_binding.dart';
import '../presentation/screens/sellers/store/views/store_screen.dart';
import '../presentation/screens/sellers/tab/views/tab_screen.dart';
import '../presentation/screens/users/cart/bindings/cart_binding.dart';
import '../presentation/screens/users/cart/views/cart_screen.dart';
import '../presentation/screens/users/navigation/bindings/navigation_binding.dart';
import '../presentation/screens/users/navigation/views/navigation_screen.dart';
import '../presentation/screens/users/search/bindings/search_binding.dart';
import '../presentation/screens/users/search/views/search_screen.dart';
import '../presentation/screens/users/setting/bindings/setting_binding.dart';
import '../presentation/screens/users/setting/views/setting_screen.dart';
import '../presentation/screens/users/wishlist/bindings/wishlist_binding.dart';
import '../presentation/screens/users/wishlist/views/wishlist_screen.dart';
import '../presentation/screens/auth/login/bindings/login_binding.dart';
import '../presentation/screens/auth/login/views/login_screen.dart';
import '../presentation/screens/auth/signup/bindings/signup_binding.dart';
import '../presentation/screens/auth/signup/views/signup_screen.dart';
import '../presentation/screens/sellers/dashboard/bindings/dashboard_binding.dart';
import '../presentation/screens/sellers/dashboard/views/dashboard_screen.dart';
import '../presentation/screens/sellers/tab/bindings/tab_binding.dart';
import '../presentation/screens/users/home/bindings/home_binding.dart';
import '../presentation/screens/users/home/views/home_screen.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.navigation,
      page: () => const NavigationScreen(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.wishlist,
      page: () => const WishListScreen(),
      binding: WishListBinding(),
    ),
    GetPage(
      name: _Paths.cart,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.search,
      page: () => const SearchScreen(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.setting,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.tab,
      page: () => const TabScreen(),
      binding: TabBinding(),
    ),
    GetPage(
      name: _Paths.setup,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.store,
      page: () => const StoreScreen(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: _Paths.product,
      page: () => const ProductScreen(),
      binding: ProductBinding(),
    ),
  ];
}
