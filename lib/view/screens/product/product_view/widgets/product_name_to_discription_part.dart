import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/core/styles.dart';

class ProductNameToDiscription extends StatelessWidget {
  const ProductNameToDiscription(
      {super.key,
      required this.name,
      required this.discount,
      required this.discription,
      required this.price,
      required this.smallDiscription});
  final String name;
  final String smallDiscription;
  final String discription;
  final int price;
  final int discount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
        sizedboxwithheight(khieght * 0.015),
        Text(smallDiscription, style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
        sizedboxwithheight(khieght * 0.015),
        Row(
          children: [
            Text('$discount% OFF',
                style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.green)),
            SizedBox(width: kwidth * 0.08),
            Text('₹$price', style: GoogleFonts.inter(fontWeight: FontWeight.bold))
          ],
        ),
        _titletext(smallDiscription),
        Text(discription, style: GoogleFonts.inter(fontSize: 12), textAlign: TextAlign.justify),
        sizedboxwithheight(khieght * 0.01),
      ],
    );
  }

  Widget _titletext(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sizedboxwithheight(khieght * 0.01),
        Text(text, style: inter),
      ],
    );
  }
}
