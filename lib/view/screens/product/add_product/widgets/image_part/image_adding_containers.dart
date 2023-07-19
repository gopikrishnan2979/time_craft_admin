import 'dart:io';
import 'package:flutter/material.dart';
import 'package:time_craft_control/controller/product/add_product_image_controller/product_image_controller.dart';
import 'package:time_craft_control/view/core/styles.dart';

class ImageAddingContainers extends StatelessWidget {
  const ImageAddingContainers({super.key, required this.productImagecontroller});
  final ProductImageController productImagecontroller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: khieght * 0.05,
      child: Center(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              if (index == productImagecontroller.imagelist.length) {
                productImagecontroller.imageAdd(index: index);
              } else {
                productImagecontroller.changeIndex(index: index);
              }
            },
            child: Container(
              decoration: BoxDecoration(color: Colors.grey, border: Border.all()),
              width: kwidth * 0.115,
              child: index != productImagecontroller.imagelist.length
                  ? Image.file(
                      File(productImagecontroller.imagelist[index]),
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Icon(
                        Icons.add,
                        color: white,
                        size: khieght * 0.035,
                      ),
                    ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            width: kwidth * 0.05,
          ),
          itemCount: productImagecontroller.imagelist.length > 4
              ? 5
              : productImagecontroller.imagelist.length + 1,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
