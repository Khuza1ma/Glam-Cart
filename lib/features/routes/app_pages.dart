import 'package:get/get.dart';
import 'package:glam_cart/features/presentation/screens/home/bindings/home_binding.dart';
import 'package:glam_cart/features/presentation/screens/home/views/home_screen.dart';
import 'package:glam_cart/features/presentation/screens/login/bindings/login_binding.dart';
import 'package:glam_cart/features/presentation/screens/login/views/login_screen.dart';
import 'package:glam_cart/features/presentation/screens/signup/bindings/signup_binding.dart';
import 'package:glam_cart/features/presentation/screens/signup/views/signup_screen.dart';
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
  ];
}
