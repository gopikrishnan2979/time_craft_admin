import 'package:flutter/material.dart';
import 'package:time_craft_control/view/core/styles.dart';

class ChoiceChipsMaked extends StatelessWidget {
  const ChoiceChipsMaked({super.key, required this.label, required this.ontap});
  final String label;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 232, 251),
          borderRadius: BorderRadius.circular(kwidth * 0.04)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: kwidth * 0.02, top: khieght * 0.01),
            child: SizedBox(
              child: Text(
                label,
                style: inter,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: khieght * 0.008,
            child: InkWell(
              onTap:ontap,
              child: Container(
                width: kwidth * 0.1,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: black,
                ),
                child: const Icon(
                  Icons.close,
                  color: white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
