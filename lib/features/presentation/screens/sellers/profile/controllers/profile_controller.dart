import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();


  void saveSeller()
  {
    if(formKey.currentState?.saveAndValidate()??false){
      var formData=formKey.currentState?.value;
      final email=formData!['email'];
      final sellerName=formData['sellerName'];
      final familyName=formData['familyName'];
      final contact=formData['contact'];
      final address=formData['address'];
      final state=formData['state'];
      final city=formData['city'];
      final pincode=formData['pincode'];
      print('$email, $sellerName $familyName $contact, $address ,$state,$city,$pincode');
    }

  }
}
