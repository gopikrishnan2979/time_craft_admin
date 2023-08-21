import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:time_craft_control/controller/dropdown_controller.dart';
import 'package:time_craft_control/services/firebase/order_services.dart';
import 'package:time_craft_control/view/core/styles.dart';

class StatusChangerPopup extends StatelessWidget {
  const StatusChangerPopup({super.key, required this.orderID, required this.ctx});
  final String orderID;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Change Status',
        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: kwidth * 0.1, vertical: khieght * 0.01),
      content: Consumer<DropdownController>(builder: (context, controller, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Status', style: interbold),
            DropdownButton(
              value: controller.value,
              isExpanded: true,
              style: inter,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: kwidth * 0.08,
              items: controller.item.map(
                (String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                },
              ).toList(),
              onChanged: (value) {
                controller.selectItem(value!);
              },
            )
          ],
        );
      }),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              String selectedChange = Provider.of<DropdownController>(context, listen: false).value;
              Navigator.pop(context);
              confirmation(selectedChange: selectedChange, orderID: orderID);
            },
            child: const Text('Change'))
      ],
    );
  }

  confirmation({required String selectedChange, required String orderID}) {
    String key = keyFinder(selectedChange);
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.red),
            Text(
              'Attention',
              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content:
            const Text('Are you sure to proceed ,Because once you updated it cannot be undone'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel', style: interbold),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              OrderService().updateStatus(
                  key: key, orderId: orderID, context: ctx, currentStatus: selectedChange);
            },
            child: Text(
              'Update',
              style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  String keyFinder(String value) {
    switch (value) {
      case 'Order Placed':
        return 'orderPlacedDate';
      case 'Order Shipped':
        return 'shippingDate';
      case 'Out For Delivery':
        return 'outForDeliveryDate';
      case 'Order Delivered':
        return 'deliveryDate';
      default:
        return '';
    }
  }
}
