import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:glam_cart/features/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../data/models/user_model.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  var isAdmin = false.obs;
  var isLoading = true.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    restoreInitialState();
    setupFirebaseAuthListener();
  }

  void setupFirebaseAuthListener() {
    FirebaseAuth.instance.authStateChanges().listen(
          (User? user) {
        updateAuthState(user);
      },
    );
  }

  void updateAuthState(User? user) {
    isAuthenticated.value = user != null;
    if (user != null) {
      fetchAndUpdateAdminStatus(user.uid);
    } else {
      isAdmin.value = false;
      saveUserState();
    }
  }

  Future<void> restoreInitialState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? storedIsAuthenticated = prefs.getBool('isAuthenticated');
    bool? storedIsAdmin = prefs.getBool('isAdmin');
    isAuthenticated.value = storedIsAuthenticated ?? FirebaseAuth.instance.currentUser != null;
    isAdmin.value = storedIsAdmin ?? false;
    isLoading.value = false;
    if (isAuthenticated.value) {
      fetchAndUpdateAdminStatus(FirebaseAuth.instance.currentUser!.uid);
    }
  }

  Future<void> fetchAndUpdateAdminStatus(String userId) async {
    UserModel? userModel = await AuthRepository(firebaseAuth: _auth).fetchUserModel(userId);
    isAdmin.value = userModel?.isAdmin ?? false;
    saveUserState();
  }

  void saveUserState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', isAuthenticated.value);
    await prefs.setBool('isAdmin', isAdmin.value);
  }
}
