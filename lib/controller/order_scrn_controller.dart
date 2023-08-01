import 'package:flutter/material.dart';
import 'package:time_craft_control/model/firebase_instance_model.dart';
import 'package:time_craft_control/model/order_model.dart';


class OrderScrnController extends ChangeNotifier {
  List<OrderModel> orderlist = [];
  List<String> orderIdlist = [];
  getOrder() async {
    orderlist.clear();
    await FirebaseInstanceModel.order.get().then((value) async {
      orderIdlist = value.docs.map((doc) => doc.id).toList();
      orderlist = value.docs.map((doc) => OrderModel.fromMap(doc)).toList();
    });
    notifyListeners();
  }
}
