import 'package:flutter/material.dart';
import 'package:time_craft_control/controller/product/dropdown_controller/dropdown_controller.dart';
import 'package:time_craft_control/view/core/styles.dart';

class DropDownProductAdd extends StatelessWidget {
  const DropDownProductAdd({super.key, required this.dropDownController});
  final DropdownController dropDownController;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropDownController.value,
      isExpanded: true,
      style: inter,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: kwidth * 0.08,
      items: dropDownController.item.map(
        (String components) {
          return DropdownMenuItem(
            value: components,
            child: Text(components),
          );
        },
      ).toList(),
      onChanged: (value) {
        String selectedvalue = value!;
        dropDownController.selectItem(selectedvalue);
      },
    );
  }
}
