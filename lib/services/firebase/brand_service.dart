import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:time_craft_control/model/brand_model.dart';
import 'package:time_craft_control/model/firebase_instance_model.dart';

class BrandServices {
  //---------------------brand image storage folder name---------------------------
  static String collectionName = 'brands';

  //----------------------Adding new brands to the collections------------------------

  Future<String?> addToBrandCollection(
      {required BrandModel brandModel, required BuildContext context}) async {
    try {
      TaskSnapshot snapshot = await FirebaseInstanceModel.firebaseStorage
          .ref()
          .child('images/brands/${brandModel.name}')
          .putFile(File(brandModel.imagepath));
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return await FirebaseInstanceModel.firestore.collection(collectionName).doc().set({
        'name': brandModel.name,
        'image': downloadUrl,
      }).then((value) => null);
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  //----------------------Removing brand from the brand collection----------------------
  Future<String?> removeFromBrand({required String brandId}) async {
    try {
      return await FirebaseInstanceModel.brands.doc(brandId).delete().then((value) => null);
    } on FirebaseException catch (e) {
      return e.message;
    }
  }
}
