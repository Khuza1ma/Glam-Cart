import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../data/models/seller_model.dart';

class SellerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> _uploadImage(Uint8List imageBytes, String uid) async {
    try {
      Reference ref = _storage.ref().child('sellerProfiles').child('$uid.png');

      UploadTask uploadTask =
          ref.putData(imageBytes, SettableMetadata(contentType: 'png'));
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<void> saveSeller(
      Seller seller, String uid, Uint8List imageBytes) async {
    try {
      String imageUrl = await _uploadImage(imageBytes, uid);

      DocumentReference sellerRef = _firestore.collection('sellers').doc(uid);
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(sellerRef);
        Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>? ?? {};

        if (snapshot.exists && data['email'] != seller.email) {
          transaction.update(sellerRef, {'email': seller.email});
        }

        Map<String, dynamic> sellerData = seller.toMap();
        sellerData['profileImg'] = imageUrl;

        transaction.set(sellerRef, sellerData, SetOptions(merge: true));
      });
    } catch (e) {
      throw Exception('Error saving seller: $e');
    }
  }

  Future<Seller> getSeller(String uid) async {
    try {
      DocumentReference sellerRef = _firestore.collection('sellers').doc(uid);
      DocumentSnapshot snapshot = await sellerRef.get();

      if (!snapshot.exists) {
        throw Exception('Seller not found');
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return Seller.fromMap(data);
    } catch (e) {
      throw Exception('Error fetching seller: $e');
    }
  }
}
