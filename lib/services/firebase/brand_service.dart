import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:time_craft_control/model/brand_model.dart';
import 'package:time_craft_control/model/firebase_instance_model.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';

class BrandServices {

  //---------------------brand image storage folder name---------------------------
  static String collectionName = 'brands';

  //----------------------Adding new brands to the collections------------------------

  addToBrandCollection({required BrandModel brandModel, required BuildContext context}) async {
    try {
      loading(context);
      TaskSnapshot snapshot = await FirebaseInstanceModel.firebaseStorage
          .ref()
          .child('images/brands/${brandModel.name}')
          .putFile(File(brandModel.imagepath));
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseInstanceModel.firestore.collection(collectionName).doc().set({
        'name': brandModel.name,
        'image': downloadUrl,
      }).then((value) {
        Navigator.of(context).pop();
        String addedmessage = 'Brand added successfully';
        alertshower(message: addedmessage, context: context, isSuccess: true);
      });
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
      alertshower(message: e.message ?? "Error", context: context);
    }
  }

  removeFromBrand({required String brandId, required BuildContext context}) async {
    try {
      await FirebaseInstanceModel.brands.doc(brandId).delete().then((value) {
        alertshower(message: 'Successfully deleted', context: context);
      });
    } on FirebaseException catch (e) {
      alertshower(message: e.message ?? "Error", context: context);
    }
  }

  //--------------------------Alert showing popup for displaying messages---------------------------------

  alertshower({required String message, required BuildContext context, bool isSuccess = false}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (isSuccess) {
                Navigator.of(context).pop();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  //---------------------------Loading showing--------------------------
  loading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Loading(),
    );
  }
}
