import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/services/firebase/brand_service.dart';
import 'package:time_craft_control/services/firebase/product_services.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/brands/add_brands/add_brand.dart';
import 'package:time_craft_control/view/screens/allproduct_and_brandproduct/product_listing.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});
  static String brandDocID = '';
  static const String routename = '/Allbrands';

  @override
  Widget build(BuildContext context) {
    CollectionReference brands =
        FirebaseFirestore.instance.collection(BrandServices.collectionName);
    return SafeArea(
      child: Scaffold(
        appBar: const AppbarCom(title: 'ALL BRANDS'),
        body: StreamBuilder(
          stream: brands.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Loading();
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('NO items added in the products'),
              );
            }
            return GridView.builder(
              padding: EdgeInsets.all(kwidth * 0.03),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kwidth * 0.03,
                crossAxisSpacing: kwidth * 0.03,
              ),
              itemBuilder: (context, index) => Stack(
                children: [
                  InkWell(
                    onTap: () {
                      brandDocID = snapshot.data!.docs[index].id;
                      Navigator.of(context).pushNamed(ProductList.routefrombrands);
                    },
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.black, borderRadius: BorderRadius.circular(kwidth * 0.04)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: kwidth * 0.3,
                            height: khieght * 0.13,
                            child: Image.network(snapshot.data!.docs[index]['image'],
                                fit: BoxFit.contain),
                          ),
                          Text(
                            snapshot.data!.docs[index]['name'],
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold, fontSize: 16, color: white),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: PopupMenuButton(
                      color: white,
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: [
                              Icon(Icons.delete),
                              Text('Delete'),
                            ],
                          ),
                        )
                      ],
                      onSelected: (value) {
                        showDialog(
                          context: context,
                          builder: (_) => delete(
                            context: context,
                            id: snapshot.data!.docs[index].id,
                            isfromBrand: true,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              itemCount: snapshot.data!.docs.length,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          foregroundColor: white,
          onPressed: () {
            Navigator.of(context).pushNamed(AddBrand.routename);
          },
          backgroundColor: const Color.fromRGBO(175, 216, 250, 1),
          child: Icon(Icons.add, size: khieght * 0.04),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

Widget delete(
    {required BuildContext context,
    required String id,
    bool isfromBrand = false,
    bool isfromProduct = false}) {
  return AlertDialog(
    title: Row(
      children: [
        const Icon(Icons.warning_amber_rounded, color: Colors.red),
        Text(
          'Delete',
          style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    content: const Text('Are you sure, Delete this item'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Cancel', style: interbold),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
          if (isfromBrand) BrandServices().removeFromBrand(brandId: id, context: context);
          if (isfromProduct) ProductServices().deleteProduct(context: context, productId: id);
        },
        child: Text(
          'Delete',
          style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
