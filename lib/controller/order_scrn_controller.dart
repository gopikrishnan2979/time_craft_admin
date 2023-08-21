import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_craft_control/model/firebase_instance_model.dart';
import 'package:time_craft_control/model/order_model.dart';
import 'package:time_craft_control/view/common/widgets/notification_widgets.dart';

class OrderScrnController extends ChangeNotifier {
  List<OrderModel> orderlist = [];
  List<String> orderIdlist = [];
  getOrder(BuildContext context) async {
    try {
      orderlist.clear();
      orderIdlist.clear();
      await FirebaseInstanceModel.order.get().then((value) async {
        orderIdlist = value.docs.map((doc) => doc.id).toList();
        orderlist = value.docs.map((doc) => OrderModel.fromMap(doc)).toList();
      });
      notifyListeners();
    } on FirebaseException catch (e) {
      alertshower(text: e.message, context: context);
    }
  }
}
