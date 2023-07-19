import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_craft_control/model/argument_models/product_argument_model.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/common/widgets/item_card.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/product/add_product/add_product.dart';
import 'package:time_craft_control/view/screens/brands/all_brands/all_brands.dart';
import 'package:time_craft_control/view/screens/product/product_view/product_view.dart';

//all product and brandwise product are showing using the same screen

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.title, required this.isFromBrand});
  final bool isFromBrand;
  final String title;
  static const String routefrombrands = 'BRANDS';
  static const String routefromhome = 'ALL PRODUCTS';
  @override
  Widget build(BuildContext context) {
    CollectionReference productref = FirebaseFirestore.instance.collection('product');
    return SafeArea(
      child: Scaffold(
        appBar: AppbarCom(title: title),
        body: StreamBuilder(
          stream: productref.snapshots(),
          builder: (context, snapshot) {
            List<QueryDocumentSnapshot<Object?>> data = [];
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            data = isFromBrand
                ? snapshot.data!.docs
                    .where((element) => element['brand'] == AllBrands.brandDocID)
                    .toList()
                : snapshot.data!.docs;
            if (snapshot.data!.docs.isEmpty || data.isEmpty) {
              return const Center(
                child: Loading(),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.all(kwidth * 0.02),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: kwidth * 0.01,
                mainAxisSpacing: khieght * 0.003,
                mainAxisExtent: khieght * 0.31,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ProductView.routename,
                        arguments: ProductArgument(data: data[index]));
                  },
                  child: ItemCard(
                    name: data[index]['name'],
                    imagepath: data[index]['imagelist'][0],
                    smalldiscription: data[index]['smalldiscription'],
                    discount: data[index]['discount'],
                    price: data[index]['price'],
                  ),
                );
              },
              itemCount: data.length,
            );
          },
        ),
        floatingActionButton: isFromBrand
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddProduct.routename);
                },
                backgroundColor: const Color.fromRGBO(175, 216, 250, 1),
                child: Icon(
                  Icons.add,
                  size: khieght * 0.04,
                  color: white,
                ),
              ),
      ),
    );
  }
}
