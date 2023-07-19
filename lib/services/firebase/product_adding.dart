import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:time_craft_control/model/product_model.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';

class ProductAddingFirestore {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //--------------------------Product adding to the collection-------------------------

  addToProductCollection({required ProductModel product, required BuildContext context}) async {
    try {
      _loading(context);
      List<String> imageurls = [];
      for (int i = 0; i < product.imagelist.length; i++) {
        TaskSnapshot snapshot = await _firebaseStorage
            .ref()
            .child('images/products/${product.name}image$i')
            .putFile(File(product.imagelist[i]));
        String downloadUrl = await snapshot.ref.getDownloadURL();
        imageurls.add(downloadUrl);
      }
      await _firebase.collection('product').doc().set({
        'name': product.name,
        'imagelist': imageurls,
        'discription': product.discription,
        'smalldiscription': product.smalldiscription,
        'brand': product.brand,
        'isAnalog': product.isanalog,
        'isWaterResistant': product.isWaterResistant,
        'gender': product.gender,
        'price': product.price,
        'discount': product.discount,
        'varients': product.varients
      }).then((value) {
        Navigator.of(context).pop();
        _alertshower(message: 'Product added successfully', context: context, isSuccess: true);
      });
    } on FirebaseException catch (e) {
      _alertshower(message: e.message.toString(), context: context);
    }
  }

  //------------------------Loading shower----------------------------

  _loading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Loading(),
    );
  }

  //-----------------------pop up for displaying messages--------------------------

  _alertshower({required String message, required BuildContext context, bool isSuccess = false}) {
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
}
