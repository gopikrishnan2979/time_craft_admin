import 'dart:io';
import 'package:flutter/material.dart';
import 'package:time_craft_control/controller/product/add_product_image_controller/product_image_controller.dart';
import 'package:time_craft_control/view/core/styles.dart';

class ImageShower extends StatelessWidget {
  const ImageShower({super.key, required this.imageController});
  final ProductImageController imageController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: khieght * 0.2,
          width: kwidth * 0.95,
          color: const Color(0xFF2C2B2B),
          child: imageController.selectedIndex == null
              ? InkWell(
                  onTap: () {
                    imageController.imageAdd(index: 0);
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Add Image', style: interwhitebold),
                        const Icon(Icons.add, color: white),
                      ],
                    ),
                  ),
                )
              : Image.file(
                  File(imageController.imagelist[imageController.selectedIndex!]),
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: imageController.selectedIndex == null
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    if (imageController.selectedIndex != null) {
                      deleteAlertDialog(context);
                    }
                  },
                  icon: const Icon(Icons.delete),
                  color: black,
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(187, 151, 151, 151),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Future deleteAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.yellow),
            Text('Delete'),
          ],
        ),
        content: const Text('Are you sure, you want to delete?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel')),
          TextButton(
            onPressed: () {
              imageController.imageRemove(index: imageController.selectedIndex!);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          )
        ],
      ),
    );
  }
}
