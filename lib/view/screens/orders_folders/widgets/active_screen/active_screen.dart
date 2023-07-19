import 'package:flutter/material.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/orders_folders/order_status.dart';
import 'package:time_craft_control/view/screens/orders_folders/widgets/order_tile.dart';

class ActiveTabBarView extends StatelessWidget {
  const ActiveTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
          horizontal: kwidth * 0.025, vertical: khieght * 0.015),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(OrderStatus.routename);
        },
        child: OrderTile(
          trailing: Text(
            'Trace',
            style: interbold,
          ),
        ),
      ),
      separatorBuilder: (context, index) => sizedboxwithheight(khieght * 0.01),
      itemCount: 10,
    );
  }
}
