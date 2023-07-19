import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImageController extends ChangeNotifier {
  List<String> imagelist = [];
  int? selectedIndex;
  void imageAdd({required int index}) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagelist.add(pickedFile.path);
      selectedIndex = index;
    }

    notifyListeners();
  }

  void changeIndex({required int index}) {
    selectedIndex = index;
    notifyListeners();
  }

  void imageRemove({required int index}) {
    imagelist.removeAt(index);
    selectedIndex = imagelist.isNotEmpty ? imagelist.length - 1 : null;
    notifyListeners();
  }
}
