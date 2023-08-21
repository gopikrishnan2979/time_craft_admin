import 'package:time_craft_control/model/address_model.dart';
import 'package:time_craft_control/model/cart_model.dart';

class OrderModel {
  List<CartModel>? cartlist;
  int? totalPrice;
  String? paymentId;
  String? discription;
  bool? israzorpay;
  String? orderStatus;
  String? userid;
  String? orderPlacedDate;
  String? shippingDate;
  String? outForDeliveryDate;
  String? deliveryDate;
  AddressModel? address;
  String? phone;

  OrderModel.fromMap(var data) {
    totalPrice = data['totalPrice'];
    paymentId = data['orderId'];
    discription = data['discription'];
    israzorpay = data['isRazorpay'];
    orderStatus = data['orderStatus'];
    userid = data['userId'];
    orderPlacedDate = data['orderPlacedDate'];
    shippingDate = data['shippingDate'];
    outForDeliveryDate = data['outForDeliveryDate'];
    phone = data['phone'];
    deliveryDate = data['deliveryDate'];

    Map cartData = data['items'] as Map;
    cartlist = [];
    for (var items in cartData.values) {
      cartlist!.add(CartModel.fromMap(data: items));
    }
    Map addressMap = data['address'] as Map;
    address = AddressModel.fromData(data: addressMap);
  }
}
