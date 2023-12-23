import 'package:get/get.dart';
import 'package:glam_cart/features/presentation/screens/users/navigation/bindings/navigation_binding.dart';
import 'package:glam_cart/features/presentation/screens/users/navigation/views/navigation_screen.dart';

import '../presentation/screens/auth/login/bindings/login_binding.dart';
import '../presentation/screens/auth/login/views/login_screen.dart';
import '../presentation/screens/auth/signup/bindings/signup_binding.dart';
import '../presentation/screens/auth/signup/views/signup_screen.dart';
import '../presentation/screens/sellers/dashboard/bindings/dashboard_binding.dart';
import '../presentation/screens/sellers/dashboard/views/dashboard_screen.dart';
import '../presentation/screens/users/home/bindings/home_binding.dart';
import '../presentation/screens/users/home/views/home_screen.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.login;

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
      name: _Paths.dashboard,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
  ];
}
