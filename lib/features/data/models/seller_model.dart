class Seller {
  String email;
  String sellerName;
  String familyName;
  String contact;
  String address;
  String state;
  String city;
  String pincode;

//<editor-fold desc="Data Methods">
  Seller({
    required this.email,
    required this.sellerName,
    required this.familyName,
    required this.contact,
    required this.address,
    required this.state,
    required this.city,
    required this.pincode,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Seller &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          sellerName == other.sellerName &&
          familyName == other.familyName &&
          contact == other.contact &&
          address == other.address &&
          state == other.state &&
          city == other.city &&
          pincode == other.pincode);

  @override
  int get hashCode =>
      email.hashCode ^
      sellerName.hashCode ^
      familyName.hashCode ^
      contact.hashCode ^
      address.hashCode ^
      state.hashCode ^
      city.hashCode ^
      pincode.hashCode;

  @override
  String toString() {
    return 'Seller{' +
        ' email: $email,' +
        ' sellerName: $sellerName,' +
        ' familyName: $familyName,' +
        ' contact: $contact,' +
        ' address: $address,' +
        ' state: $state,' +
        ' city: $city,' +
        ' pincode: $pincode,' +
        '}';
  }

  Seller copyWith({
    String? email,
    String? sellerName,
    String? familyName,
    String? contact,
    String? address,
    String? state,
    String? city,
    String? pincode,
  }) {
    return Seller(
      email: email ?? this.email,
      sellerName: sellerName ?? this.sellerName,
      familyName: familyName ?? this.familyName,
      contact: contact ?? this.contact,
      address: address ?? this.address,
      state: state ?? this.state,
      city: city ?? this.city,
      pincode: pincode ?? this.pincode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'sellerName': this.sellerName,
      'familyName': this.familyName,
      'contact': this.contact,
      'address': this.address,
      'state': this.state,
      'city': this.city,
      'pincode': this.pincode,
    };
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      email: map['email'] as String ?? '',
      sellerName: map['sellerName'] as String ?? '',
      familyName: map['familyName'] as String ?? '',
      contact: map['contact'] as String ?? '',
      address: map['address'] as String ?? '',
      state: map['state'] as String ?? '',
      city: map['city'] as String ?? '',
      pincode: map['pincode'] as String ?? '',
    );
  }

//</editor-fold>
}
