import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/core/styles.dart';

class AddBrandTextField extends StatelessWidget {
  const AddBrandTextField({super.key,required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: black,
      keyboardType: TextInputType.name,
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Brand',
        labelStyle: GoogleFonts.inter(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: black,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: black,
          ),
        ),
      ),
    );
  }
}