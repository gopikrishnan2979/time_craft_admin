import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/banners/banners.dart';
import 'package:time_craft_control/view/screens/brands/all_brands/all_brands.dart';
import 'package:time_craft_control/view/screens/allproduct_and_brandproduct/product_listing.dart';
import 'package:time_craft_control/view/screens/orders_folders/orders_screen.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});
  static const String routename = '/Home';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 3,
            shadowColor: black,
            surfaceTintColor: white,
            title: Text(
              'ADMIN PANEL',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: kwidth * 0.15),
            child: SizedBox(
              height: khieght * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(ProductList.routefromhome);
                    },
                    style: buttonstyle(),
                    child: buttonChild(text: 'All Products'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AllBrands.routename);
                    },
                    style: buttonstyle(),
                    child: buttonChild(text: 'All Brands'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Banners.routename);
                    },
                    style: buttonstyle(),
                    child: buttonChild(text: 'Banners'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Orders.routename);
                    },
                    style: buttonstyle(),
                    child: buttonChild(text: 'Orders'),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  ButtonStyle buttonstyle() {
    return ButtonStyle(
        fixedSize: MaterialStatePropertyAll(Size(kwidth * 0.7, khieght * 0.06)),
        backgroundColor: const MaterialStatePropertyAll(black),
        foregroundColor: const MaterialStatePropertyAll(white),
        shape: const MaterialStatePropertyAll(ContinuousRectangleBorder()));
  }

  Widget buttonChild({required String text}) {
    return Text(
      text,
      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
