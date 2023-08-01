import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';
import 'package:time_craft_control/view/core/styles.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer(
      {super.key,
      required this.imagePath,
      required this.width,
      required this.height,
      this.fromNetwork = false});
  final String? imagePath;
  final double width;
  final double height;
  final bool fromNetwork;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: imagePath == null ? const Color(0xFF2C2B2B) : white,
      child: imagePath == null
          ? Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Image',
                    style: interwhitebold,
                  ),
                  const Icon(
                    Icons.add,
                    color: white,
                  )
                ],
              ),
            )
          : fromNetwork
              ? CachedNetworkImage(
                  imageUrl: imagePath!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Loading(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                ),
    );
  }
}
