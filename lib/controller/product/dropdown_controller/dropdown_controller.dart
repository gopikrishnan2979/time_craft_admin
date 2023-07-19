import 'package:flutter/material.dart';

class DropdownController extends ChangeNotifier {
  DropdownController({required this.item,required this.value});
  final List<String> item;
  String value;

  selectItem(String selectedValue) {
    value = selectedValue;
    notifyListeners();
  }
}
