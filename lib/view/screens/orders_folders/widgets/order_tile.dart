import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/core/styles.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    super.key,
    required this.trailing,
    required this.imagePath,
    required this.name,
    required this.totalPrice,
    this.varient,
    this.orderNo,
  });
  final Widget trailing;
  final String imagePath;
  final String name;
  final String? orderNo;
  final int totalPrice;
  final String? varient;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(kwidth * 0.03)),
      height: khieght * 0.15,
      child: Center(
        child: SizedBox(
          height: khieght * 0.125,
          width: kwidth * 0.9,
          child: Row(
            children: [
              Image.network(imagePath, width: khieght * 0.125, fit: BoxFit.fitHeight),
              SizedBox(width: kwidth * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    text16interbold(name),
                    text12inter(orderNo != null ? 'Order: $orderNo' : 'varient:$varient'),
                    text16interbold('₹$totalPrice'),
                  ],
                ),
              ),
              SizedBox(width: kwidth * 0.15, child: trailing)
            ],
          ),
        ),
      ),
    );
  }

  Widget text16interbold(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget text12inter(String text) {
    return Text(text, style: GoogleFonts.inter(fontSize: 12));
  }
}
