import 'package:flutter/material.dart';
import 'package:time_craft_control/model/product_model.dart';

class Validation {
  Validation({required this.product, required this.context});
  final ProductModel product;
  final BuildContext context;
  bool validation() {
    product.price = int.tryParse(product.stringprice);
    product.discount = int.tryParse(product.stringdiscount);
    if (product.imagelist.isEmpty) {
      alertshower(
        message: 'Must contain atleast 1 image',
      );
      return false;
    } else if (product.name == '') {
      alertshower(message: 'Name is invalid');
      return false;
    } else if (product.brand == '') {
      alertshower(message: 'Brand not selected');
      return false;
    } else if (product.waterResistantType == '') {
      alertshower(message: 'Water resistant type not selected');
      return false;
    } else if (product.type == '') {
      alertshower(message: 'Dial type not selected');
      return false;
    } else if (product.price == null || (product.price ?? -1) < 0) {
      alertshower(message: 'Invalid price');
      return false;
    } else if (product.discount == null ||
        (product.discount ?? -1) < 0 ||
        (product.discount ?? -1) > 100) {
      alertshower(message: 'Invalid discount\n(discount should have to be in between 0 to 100)');
      return false;
    } else if (product.varients.isEmpty) {
      alertshower(
        message: 'Must contain atleast 1 varient',
      );
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

  alertshower({required String message}) {
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
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String? emailvalidator(String value) {
    return value.contains('@') && value.contains('.') && value != '' ? null : 'Enter a valid email';
  }

  String? passwordvalidator(String value) {
    if (value == '') {
      return 'Password cannot be empty';
    }
    return value.length > 5 ? null : 'Password must contain minimum 6 characters';
  }

  String? phonevalidator(String value) {
    return value.length == 10 ? null : 'Number must contain 10 digits';
  }

  String? confirmPasswordValidation(String password, String value) {
    return value == password && value != '' ? null : 'Password must be same as entered above';
  }
}
