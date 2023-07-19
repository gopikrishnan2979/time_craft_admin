import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/core/styles.dart';

class TextFieldCom extends StatelessWidget {
  const TextFieldCom({super.key, required this.label,required this.keyboardtype,required this.controller});
  final String label;
  final TextInputType keyboardtype;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: black,
      keyboardType: keyboardtype,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        labelStyle: GoogleFonts.inter(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: black,
          ),
        ),
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
