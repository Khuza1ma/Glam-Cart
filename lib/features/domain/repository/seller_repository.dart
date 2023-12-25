import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/seller_model.dart';

class SellerRepository {
  Future<void> saveSeller(Seller seller, String uid) async {
    DocumentReference sellerRef =
        FirebaseFirestore.instance.collection('sellers').doc(uid);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(sellerRef);

      Map<String, dynamic> data =
          snapshot.data() as Map<String, dynamic>? ?? {};

      if (snapshot.exists && data['email'] != seller.email) {
        transaction.update(sellerRef, {'email': seller.email});
      }
      transaction.set(sellerRef, seller.toMap(), SetOptions(merge: true));
    }).catchError((e) {
      throw Exception('Error saving seller: $e');
    });
  }
}
