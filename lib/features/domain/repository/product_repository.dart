import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:glam_cart/features/data/models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> _uploadImages(
    List<Uint8List> imageBytesList,
    String uid,
    String productName,
  ) async {
    List<String> downloadUrls = [];
    try {
      for (int i = 0; i < imageBytesList.length; i++) {
        Reference ref = _storage.ref().child('products').child(uid).child(
            '$productName$i${DateTime.now().millisecondsSinceEpoch}.png');
        UploadTask uploadTask = ref.putData(
            imageBytesList[i], SettableMetadata(contentType: 'image/png'));
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
      return downloadUrls;
    } catch (e) {
      throw Exception('Error uploading images: $e');
    }
  }

  Future<void> saveProduct(
    Product product,
    String sellerId,
    List<Uint8List> imageBytesList,
  ) async {
    try {
      DocumentReference productRef = _firestore
          .collection('sellers')
          .doc(sellerId)
          .collection('products')
          .doc();

      String productId = productRef.id;

      List<String> imageUrls = await _uploadImages(
        imageBytesList,
        sellerId,
        product.productName,
      );
      product.productImages = imageUrls;

      Map<String, dynamic> productData = product.toMap();
      productData['productId'] = productId;

      await productRef.set(productData);
    } catch (e) {
      throw Exception('Error saving product: $e');
    }
  }

  Future<List<Product>> getProducts(String sellerId) async {
    List<Product> products = [];

    try {
      QuerySnapshot productSnapshot = await _firestore
          .collection('sellers')
          .doc(sellerId)
          .collection('products')
          .get();

      for (var doc in productSnapshot.docs) {
        products.add(Product.fromMap(doc.data() as Map<String, dynamic>));
      }

      return products;
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<void> deleteProduct(String sellerId, String productId) async {
    try {
      DocumentReference productRef = _firestore
          .collection('sellers')
          .doc(sellerId)
          .collection('products')
          .doc(productId);

      await productRef.delete();
      ListResult result =
          await _storage.ref('products/$sellerId/$productId').listAll();
      for (var ref in result.items) {
        await ref.delete();
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
