import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glam_cart/core/config/app_colors.dart';
import 'features/presentation/screens/auth/login/controllers/auth_controller.dart';
import 'features/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(
      () {
        if (authController.isLoading.value) {
          return const MaterialApp(
            home: CircularProgressIndicator(),
          );
        } else {
          String initialRoute;
          if (authController.isAuthenticated.value) {
            initialRoute =
                authController.isAdmin.value ? Routes.tab : Routes.navigation;
          } else {
            initialRoute = AppPages.initial;
          }
          return GetMaterialApp(
            title: 'Glam Cart',
            theme: ThemeData().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
                primary: AppColors.kF83758,
              ),
            ),
            initialRoute: initialRoute,
            getPages: AppPages.routes,
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}
