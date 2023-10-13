import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';
import 'package:time_craft_control/view/core/styles.dart';

SnackBar snackBarDesign({required String text, Color? color}) {
  return SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(milliseconds: 800),
    margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
    backgroundColor: color ?? const Color.fromARGB(122, 0, 0, 0),
    elevation: 15,
    content: Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Text(text, style: GoogleFonts.ptSerif(color: white, fontSize: 16)),
      ),
    ),
  );
}

loading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Loading(),
    );
  }

alertshower({required String? text, required BuildContext context}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Alert'),
      content: Text(text ?? 'Something error happened'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
