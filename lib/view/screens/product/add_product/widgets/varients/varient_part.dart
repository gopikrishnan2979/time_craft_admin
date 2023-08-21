import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/controller/product/color_adding_controller/color_varient_adding_controller.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/common_textfield.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/varients/varients_grid.dart';

class VarientContainer extends StatelessWidget {
  VarientContainer({super.key, required this.varientController});
  final VarientAddingController varientController;
  final TextEditingController _varientTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kwidth * 0.01),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          kwidth * 0.03,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Varients', style: interbold),
          VarientsGrid(varientAddingController: varientController),
          SizedBox(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  addVarientPopUp(context);
                },
                style: buttonStyle(),
                child: Text('Add Varients', style: interwhitebold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addVarientPopUp(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add Varient',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldCom(
                label: 'Add Varients',
                controller: _varientTextController,
                keyboardtype: TextInputType.name),
            sizedboxwithheight(khieght * 0.005),
            ElevatedButton(
              onPressed: () {
                String value = _varientTextController.text.trim();
                varientController.addVarient(value);
                Navigator.of(context).pop();
              },
              style: buttonStyle(),
              child: Text('Add Varient', style: interwhitebold),
            )
          ],
        ),
      ),
    );
  }

  ButtonStyle buttonStyle() {
    return const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(black),
        foregroundColor: MaterialStatePropertyAll(white));
  }
}
