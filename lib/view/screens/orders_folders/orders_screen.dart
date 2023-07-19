import 'package:flutter/material.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/orders_folders/widgets/active_screen/active_screen.dart';
import 'package:time_craft_control/view/screens/orders_folders/widgets/appbar.dart';
import 'package:time_craft_control/view/screens/orders_folders/widgets/complete_screen/complete_screen.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  static const String routename = '/Orders';

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(  
          backgroundColor: white,
            appBar:  AppbarOrders(),
            body: TabBarView(
                children: [ActiveTabBarView(), CompleteTabBarView()])),
      ),
    );
  }
}
