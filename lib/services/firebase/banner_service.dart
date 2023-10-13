import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:time_craft_control/model/firebase_instance_model.dart';

class BannerService {
  //---------------------collection name---------------------------

  static const String collectionName = 'banners';

  //---------------------Add banners to the firebase--------------------------

  Future<String?> addBanner({required BuildContext context, required String imagepath}) async {
    try {
      
      File imageFile = File(imagepath);
      String fileName = imageFile.path.split('/').last;
      var snapshot = await FirebaseInstanceModel.firebaseStorage
          .ref()
          .child('images/$collectionName/$fileName')
          .putFile(imageFile);
      String downloadUrl = await snapshot.ref.getDownloadURL();
     return await FirebaseInstanceModel.firestore
          .collection(collectionName)
          .doc()
          .set({'image': downloadUrl}).then((value) => null);
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

// ----------------------Banner deleting-------------------------

  bannerDeleting(String bannerRef) {
    FirebaseStorage.instance.refFromURL(bannerRef).delete();
  }
}
