import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/core/styles.dart';

class AppbarCom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppbarCom({super.key, required this.title});

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
          icon: const Icon(Icons.arrow_back_outlined, size: 25),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(color: black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
