import 'package:flutter/material.dart';
import 'package:time_craft_control/controller/product/color_adding_controller/color_varient_adding_controller.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/varients/choice_chip_maked.dart';

class VarientsGrid extends StatelessWidget {
  const VarientsGrid({super.key, required this.varientAddingController});
  final VarientAddingController varientAddingController;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: khieght * 0.01),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: kwidth * 0.03,
          mainAxisExtent: khieght * 0.045,
          mainAxisSpacing: khieght * 0.015),
      itemBuilder: (context, index) => ChoiceChipsMaked(
        label: varientAddingController.varients[index],
        ontap: () {
          varientAddingController.deleteVarient(index);
        },
      ),
      itemCount: varientAddingController.varients.length,
    );
  }
}
