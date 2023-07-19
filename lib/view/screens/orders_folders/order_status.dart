import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/orders_folders/order_detail.dart';
import 'package:time_craft_control/view/screens/orders_folders/widgets/order_tile.dart';

class OrderStatus extends StatelessWidget {
  OrderStatus({super.key});

  final List<String> items = [
    'Select item',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  static const String routename = '/Orderstatus';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: const AppbarCom(title: 'ORDER STATUS'),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: kwidth * 0.025, vertical: khieght * 0.015),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderTile(
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(OrderDetails.routename);
                  },
                  icon: Icon(
                    Icons.navigate_next,
                    size: kwidth * 0.08,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: kwidth * 0.025, top: khieght * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rowmaker('Order placed', Colors.green),
                    verticalline(Colors.green),
                    rowmaker('Shipped', Colors.green),
                    verticalline(Colors.green),
                    rowmaker('Out for delivery', Colors.grey),
                    verticalline(Colors.grey),
                    rowmaker('Delivery', Colors.grey),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  'Change Status',
                  style: GoogleFonts.inter(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: kwidth * 0.1, vertical: khieght * 0.01),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Status', style: interbold),
                    DropdownButton(
                      value: 'Select item',
                      isExpanded: true,
                      style: inter,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: kwidth * 0.08,
                      items: items.map(
                        (String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {},
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  TextButton(onPressed: () {}, child: const Text('Change'))
                ],
              ),
            );
          },
          backgroundColor: black,
          child: const Icon(
            Icons.add,
            color: white,
          ),
        ),
      ),
    );
  }

  Widget rowmaker(String text, Color color) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          width: khieght * 0.04,
          height: khieght * 0.015,
        ),
        Text(text)
      ],
    );
  }

  Widget verticalline(Color color) {
    return SizedBox(
      height: khieght * 0.08,
      width: kwidth * 0.085,
      child: VerticalDivider(
        thickness: kwidth * 0.005,
        color: color,
      ),
    );
  }
}
