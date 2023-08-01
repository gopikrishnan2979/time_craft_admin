import 'package:flutter/material.dart';
import 'package:time_craft_control/model/argument_models/product_arg.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/product/product_view/widgets/product_delivery_and_details.dart';
import 'package:time_craft_control/view/screens/product/product_view/widgets/product_imgview.dart';
import 'package:time_craft_control/view/screens/product/product_view/widgets/product_name_to_discription_part.dart';
import 'package:time_craft_control/view/screens/product/product_view/widgets/product_varients_to_last.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.productDataO});
  final ProductArgument productDataO;

  static const String routename = '/Productview';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: const AppbarCom(title: 'PRODUCT'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductPageview(imagelist: productDataO.data['imagelist']),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kwidth * 0.08),
                child: ProductNameToDiscription(
                    name: productDataO.data['name'],
                    discount: productDataO.data['discount'],
                    discription: productDataO.data['discription'],
                    price: productDataO.data['price'],
                    smallDiscription: productDataO.data['smalldiscription']),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kwidth * 0.08),
                child: ProductDeliveryAndDetails(
                    isAnalog: productDataO.data['isAnalog'],
                    isWaterResistant: productDataO.data['isWaterResistant']),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kwidth * 0.08),
                child: ProductVarientsToLast(varients: productDataO.data['varients']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
