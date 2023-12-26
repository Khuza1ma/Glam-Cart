class Seller {
  String email;
  String sellerName;
  String familyName;
  String contact;
  String address;
  String state;
  String city;
  String pincode;
  String profileImg;

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
    required this.profileImg,
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
          pincode == other.pincode &&
          profileImg == other.profileImg);

  @override
  int get hashCode =>
      email.hashCode ^
      sellerName.hashCode ^
      familyName.hashCode ^
      contact.hashCode ^
      address.hashCode ^
      state.hashCode ^
      city.hashCode ^
      pincode.hashCode ^
      profileImg.hashCode;

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
        ' profileImg: $profileImg,' +
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
    String? profileImg,
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
      profileImg: profileImg ?? this.profileImg,
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
      'profileImg': this.profileImg,
    };
  }

  factory Seller.fromMap(Map<String, dynamic> map) {
    return Seller(
      email: map['email'] as String? ?? '',
      sellerName: map['sellerName'] as String? ?? '',
      familyName: map['familyName'] as String? ?? '',
      contact: map['contact'] as String? ?? '',
      address: map['address'] as String? ?? '',
      state: map['state'] as String? ?? '',
      city: map['city'] as String? ?? '',
      pincode: map['pincode'] as String? ?? '',
      profileImg: map['profileImg'] as String? ?? '',
    );
  }

//</editor-fold>
}
