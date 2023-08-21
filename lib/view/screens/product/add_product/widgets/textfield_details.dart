import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/common_textfield.dart';

class TextFieldDetails extends StatelessWidget {
  const TextFieldDetails(
      {super.key,
      required this.nameController,
      required this.discriptionController,
      required this.smallDiscriptionController});
  final TextEditingController nameController;
  final TextEditingController discriptionController;
  final TextEditingController smallDiscriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldCom(
          label: 'Product Name',
          keyboardtype: TextInputType.name,
          controller: nameController,
        ),
        sizedboxwithheight(khieght * 0.02),
        TextFieldCom(
            label: 'Small Discription',
            keyboardtype: TextInputType.text,
            controller: smallDiscriptionController),
        sizedboxwithheight(khieght * 0.02),
        TextField(
          maxLines: 5,
          cursorColor: black,
          keyboardType: TextInputType.text,
          controller: discriptionController,
          decoration: InputDecoration(
            labelText: 'Discription',
            alignLabelWithHint: true,
            hintTextDirection: TextDirection.rtl,
            labelStyle: GoogleFonts.inter(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: black),
            ),
          ),
        ),
      ],
    );
  }
}
