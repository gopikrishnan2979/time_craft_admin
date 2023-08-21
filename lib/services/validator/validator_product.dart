import 'package:flutter/material.dart';
import 'package:time_craft_control/model/product_model.dart';
import 'package:time_craft_control/view/common/widgets/notification_widgets.dart';

class Validation {
  Validation({required this.product, required this.context});
  final ProductModel product;
  final BuildContext context;
  bool validation() {
    product.price = int.tryParse(product.stringprice);
    product.discount = int.tryParse(product.stringdiscount);
    if (product.imagelist.isEmpty) {
      alertshower(text: 'Must contain atleast 1 image', context: context);
      return false;
    } else if (product.name == '' ||
        RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(product.name)) {
      alertshower(text: 'Name is invalid', context: context);
      return false;
    } else if (product.brand == '') {
      alertshower(text: 'Brand not selected', context: context);
      return false;
    } else if (product.waterResistantType == '') {
      alertshower(context: context, text: 'Water resistant type not selected');
      return false;
    } else if (product.type == '') {
      alertshower(text: 'Dial type not selected', context: context);
      return false;
    } else if (product.price == null || (product.price ?? -1) < 0) {
      alertshower(text: 'Invalid price', context: context);
      return false;
    } else if (product.discount == null ||
        (product.discount ?? -1) < 0 ||
        (product.discount ?? -1) > 100) {
      alertshower(
          text: 'Invalid discount\n(discount should have to be in between 0 to 100)',
          context: context);
      return false;
    } else if (product.varients.isEmpty) {
      alertshower(text: 'Must contain atleast 1 varient', context: context);
      return false;
    } else {
      if (product.type == 'Analog') {
        product.isanalog = true;
      } else if (product.type == 'Digital') {
        product.isanalog = false;
      }
      if (product.waterResistantType == 'No') {
        product.isWaterResistant = false;
      } else if (product.waterResistantType == 'Yes') {
        product.isWaterResistant = true;
      }
      return true;
    }
  }
}
