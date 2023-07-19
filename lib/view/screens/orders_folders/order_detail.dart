import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/core/styles.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  static const String routename = '/Orderdetails';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: const AppbarCom(title: 'ORDER DETAILS'),
      body: Column(
        children: [
          SizedBox(
            height: khieght * 0.4,
            child: PageView.builder(
              itemBuilder: (context, index) => Image.network(imgpath,
                  fit: index == 1 ? BoxFit.fitHeight : BoxFit.fitWidth),
              itemCount: 3,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: kwidth * 0.03, vertical: khieght * 0.01),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedboxwithheight(khieght * 0.02),
                    Text(
                      'Order No : 000000',
                      style: GoogleFonts.inter(
                          fontSize: kwidth * 0.04, fontWeight: FontWeight.bold),
                    ),
                    sizedboxwithheight(khieght * 0.03),
                    textinter('Name : buyername'),
                    sizedboxwithheight(khieght * 0.03),
                    textinter('Price : ₹ 799'),
                    sizedboxwithheight(khieght * 0.03),
                    textinter('Quantity : 1'),
                    sizedboxwithheight(khieght * 0.03),
                    textinter('Gmail: username@gmail.com'),
                    sizedboxwithheight(khieght * 0.03),
                    textinter('Shipping Address :'),
                    sizedboxwithheight(khieght * 0.03),
                    textinter('housename, place, post, landmark, pincode'),
                    sizedboxwithheight(khieght * 0.03),
                    textinter('phone : XXXXXXXXXXX'),
                    sizedboxwithheight(khieght * 0.03),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget textinter(String text) {
    return Text(
      text,
      style: inter,
    );
  }
}
