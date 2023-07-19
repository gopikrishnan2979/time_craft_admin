import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/core/styles.dart';

class AppbarOrders extends StatelessWidget implements PreferredSizeWidget {
  const AppbarOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: white,
      surfaceTintColor: white,
      elevation: 3,
      shadowColor: black,
      leadingWidth: kwidth * 0.13,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            size: 25,
          ),
        ),
      ),
      bottom: const TabBar(
        tabs: [
          Tab(
            text: 'Active',
          ),
          Tab(
            text: 'Completed',
          )
        ],
        labelColor: black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: black,
        unselectedLabelColor: black,
      ),
      title: Text(
        'ORDERS',
        style: GoogleFonts.inter(
            color: black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.8);
}
