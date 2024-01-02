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
      DocumentSnapshot snapshot = await productRef.get();

      if (!snapshot.exists) {
        throw Exception("Product not found");
      }

      Product product =
          Product.fromMap(snapshot.data() as Map<String, dynamic>);

      // Delete images from Firebase Storage
      for (String imageUrl in product.productImages) {
        Reference ref = _storage.refFromURL(imageUrl);
        await ref.delete();
      }
      await productRef.delete();
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  Future<void> updateProduct(
    Product updatedProduct,
    String sellerId,
    String productId,
    List<Uint8List>? newImageBytesList,
  ) async {
    try {
      DocumentReference productRef = _firestore
          .collection('sellers')
          .doc(sellerId)
          .collection('products')
          .doc(productId);

      // Step 1: Fetch existing image URLs
      DocumentSnapshot snapshot = await productRef.get();
      Product existingProduct =
          Product.fromMap(snapshot.data() as Map<String, dynamic>);
      List<String> oldImageUrls = existingProduct.productImages;

      // Step 2: Delete old images from Firebase Storage
      for (String url in oldImageUrls) {
        Reference ref = _storage.refFromURL(url);
        await ref.delete();
      }

      // Step 3: Upload new images
      List<String> newImageUrls = [];
      if (newImageBytesList != null && newImageBytesList.isNotEmpty) {
        newImageUrls = await _uploadImages(
          newImageBytesList,
          sellerId,
          updatedProduct.productName,
        );
      }
      updatedProduct.productImages = newImageUrls;

      // Step 4: Update Firestore document
      Map<String, dynamic> updatedProductData = updatedProduct.toMap();
      await productRef.update(updatedProductData);
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }
}
