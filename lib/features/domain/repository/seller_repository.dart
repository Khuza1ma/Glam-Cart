import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/seller_model.dart';

class SellerRepository {
  Future<void> saveSeller(Seller seller, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('/sellers')
          .doc(uid)
          .set(seller.toMap());
    } catch (e) {
      throw Exception('Error saving seller: $e');
    }
  }
}