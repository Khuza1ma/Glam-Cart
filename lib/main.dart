import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Obx(
      () {
        String initialRoute;
        if (authController.isAuthenticated.value) {
          initialRoute =
              authController.isAdmin.value ? Routes.home : Routes.navigation;
        } else {
          initialRoute = AppPages.INITIAL;
        }
        return GetMaterialApp(
          title: 'Glam Cart',
          initialRoute: initialRoute,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
