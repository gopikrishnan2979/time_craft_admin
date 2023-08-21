import 'package:flutter/material.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';
import 'package:time_craft_control/view/core/styles.dart';

class ProductPageview extends StatelessWidget {
  final List imagelist;
  const ProductPageview({super.key, required this.imagelist});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: khieght * 0.5,
      width: double.infinity,
      child: PageView.builder(
        itemCount: imagelist.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: double.infinity,
            child: Image.network(
              imagelist[index],
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) => const ColoredBox(
                color: Colors.grey,
                child: Loading(),
              ),
            ),
          );
        },
      ),
    );
  }
}
