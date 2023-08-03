import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseInstanceModel {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  /// Firebase firestore instance
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ///firebase storage instance
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  /// admin side data collection References
  static final CollectionReference products = firestore.collection('product');
  static final CollectionReference banners = firestore.collection('banners');
  static final CollectionReference brands = firestore.collection('brands');
  static final CollectionReference order = firestore.collection('orders');

  /// User Side Data Collection References
  static final CollectionReference user = firestore.collection('users');
}
