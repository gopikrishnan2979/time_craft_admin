import 'package:flutter/material.dart';

class VarientAddingController extends ChangeNotifier {
  List<String> varients = [];

  addVarient(String newColor) {
    String color = '';
    for (int i = 0; i < newColor.length; i++) {
      if (i == 0) {
        color += newColor[i].toUpperCase();
      } else {
        color += newColor[i];
      }
    }
    if ((!varients.contains(color)) && !(color == '')) {
      varients.add(color);
      notifyListeners();
      //poping should have to write here
    }else{
      //impliment color is added error
    }
  }

  deleteVarient(int removingIndex) {
    varients.removeAt(removingIndex);
    notifyListeners();
  }
}
