import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_craft_control/model/firebase_instance_model.dart';

class AuthService {
  Future<bool> adminSignIn({required String email, required String password}) async {
    try {
      return await FirebaseInstanceModel.auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        return true;
      });
    } on FirebaseException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }
}
