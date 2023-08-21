import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/brands/all_brands/all_brands.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.name,
      required this.imagepath,
      required this.smalldiscription,
      required this.discount,
      required this.productId,
      required this.price});
  final String productId;
  final String name;
  final String smalldiscription;
  final String imagepath;
  final int discount;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kwidth * 0.02),
        color: Colors.white,
        border: Border.all(color: const Color.fromARGB(255, 200, 200, 200)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                width: kwidth * 0.5,
                height: khieght * 0.2,
                fit: BoxFit.fitHeight,
                imagepath,
                errorBuilder: (context, error, stackTrace) =>
                    SizedBox(width: kwidth * 0.5, height: khieght * 0.2),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: GoogleFonts.inter(fontSize: 16)),
                      Text(
                        smalldiscription,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(fontSize: 12),
                      ),
                      Row(
                        children: [
                          Text('$discount% OFF', style: GoogleFonts.inter(color: Colors.green)),
                          const SizedBox(width: 30),
                          Text('₹$price')
                        ],
                      ),
                      Text('Delivery in 5 days', style: GoogleFonts.inter(fontSize: 10)),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            right: 0,
            child: PopupMenuButton(
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
                  builder: (_) => delete(context: context, id: productId, isfromProduct: true),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
