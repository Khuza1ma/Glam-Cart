class Product {
  String productName;
  String description;
  List<String> productImages;
  String price;
  String category;
  String productId;

//<editor-fold desc="Data Methods">
  Product({
    required this.productName,
    required this.description,
    required this.productImages,
    required this.price,
    required this.category,
    required this.productId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          runtimeType == other.runtimeType &&
          productName == other.productName &&
          description == other.description &&
          productImages == other.productImages &&
          price == other.price &&
          category == other.category &&
          productId == other.productId);

  @override
  int get hashCode =>
      productName.hashCode ^
      description.hashCode ^
      productImages.hashCode ^
      price.hashCode ^
      category.hashCode ^
      productId.hashCode;

  @override
  String toString() {
    return 'Product{' +
        ' productName: $productName,' +
        ' description: $description,' +
        ' productImages: $productImages,' +
        ' price: $price,' +
        ' category: $category,' +
        ' productId: $productId,' +
        '}';
  }

  Product copyWith({
    String? productName,
    String? description,
    List<String>? productImages,
    String? price,
    String? category,
    String? productId,
  }) {
    return Product(
      productName: productName ?? this.productName,
      description: description ?? this.description,
      productImages: productImages ?? this.productImages,
      price: price ?? this.price,
      category: category ?? this.category,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': this.productName,
      'description': this.description,
      'productImages': this.productImages,
      'price': this.price,
      'category': this.category,
      'productId': this.productId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productName: map['productName'] as String? ?? '',
      description: map['description'] as String? ?? '',
      productImages: map['productImages'] != null
          ? List<String>.from(map['productImages'])
          : [],
      price: map['price'] as String? ?? '',
      category: map['category'] as String? ?? '',
      productId: map['productId'] as String? ?? '',
    );
  }
//</editor-fold>
}
