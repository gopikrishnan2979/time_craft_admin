import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:time_craft_control/model/firebase_instance_model.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';

class BannerService {

  //---------------------collection name---------------------------

  static const String collectionName = 'banners';

  //---------------------Add banners to the firebase--------------------------

  addBanner({required BuildContext context, required String imagepath}) async {
    try {
      loading(context);
      File imageFile = File(imagepath);
      String fileName = imageFile.path.split('/').last;
      var snapshot =
          await FirebaseInstanceModel.firebaseStorage.ref().child('images/$collectionName/$fileName').putFile(imageFile);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseInstanceModel.firestore
          .collection(collectionName)
          .doc()
          .set({'image': downloadUrl}).then((value) {
        Navigator.of(context).pop();
        String addedmessage = 'Banner added successfully';
        alertshower(message: addedmessage, context: context, isSuccess: true);
      });
    } on FirebaseException catch (e) {
      Navigator.of(context).pop();
      alertshower(message: e.message.toString(), context: context);
    }
  }

  //---------------------------alert shower popup for displaying errors and messages--------------------------

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

  //-----------------------------Loading popup------------------------------

  loading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Loading(),
    );
  }

  bannerDeleting (String bannerRef){
    FirebaseStorage.instance
                                  .refFromURL(bannerRef)
                                  .delete();
                             
  }
}
