import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  var isAdmin = false.obs;

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      isAuthenticated.value = user != null;
      if (user != null) {
        fetchUserRole(user.uid);
      }
    });
  }

  void fetchUserRole(String userId) async {
    var doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists && doc.data()!['isAdmin'] == true) {
      isAdmin.value = true;
    } else {
      isAdmin.value = false;
    }
  }
}
