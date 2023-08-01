import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_craft_control/model/firebase_instance_model.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';

class OrderService {
  updateStatus(
      {required String key,
      required String orderId,
      required BuildContext context,
      required String currentStatus}) async {
    try {
      var data = await FirebaseInstanceModel.order.doc(orderId).get();
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => const Loading(),
        );
      }
      if (data[key] == 'Not setted') {
        String date = DateTime.now().toString();

        await FirebaseInstanceModel.order
            .doc(orderId)
            .update({key: date, 'orderStatus': currentStatus}).then((value) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('Successfully updated'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'))
              ],
            ),
          );
        });
      } else {
        if (context.mounted) {
          alertshower(context: context, e: 'Setted earlier, Can be set only once');
        }
      }
    } on FirebaseException catch (e) {
      alertshower(context: context, e: e.message.toString());
    }
  }

  alertshower({required BuildContext context, required String e}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert'),
        content: Text(e),
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
}
