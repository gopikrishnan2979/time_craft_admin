import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_craft_control/controller/order_scrn_controller.dart';
import 'package:time_craft_control/model/argument_models/order_details_arg.dart';
import 'package:time_craft_control/model/order_model.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/orders_folders/order_status.dart';
import 'package:time_craft_control/view/screens/orders_folders/widgets/order_tile.dart';

class CompleteTabBarView extends StatelessWidget {
  const CompleteTabBarView({super.key});
  final String cartImage =
      'https://media.istockphoto.com/id/1206806317/vector/shopping-cart-icon-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=1RRQJs5NDhcB67necQn1WCpJX2YMfWZ4rYi1DFKlkNA=';

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderScrnController>(builder: (context, orderController, child) {
      List<OrderModel> completeList = [];
      List<String> activeListId = [];
      var orderList = orderController.orderlist;
      var orderIdlist = orderController.orderIdlist;
      for (int i = 0; i < orderList.length; i++) {
        if (orderList[i].orderStatus == 'Order Delivered') {
          completeList.add(orderList[i]);
          activeListId.add(orderIdlist[i]);
        }
      }
      int cartcount = 0;
      return completeList.isNotEmpty
          ? ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: kwidth * 0.025, vertical: khieght * 0.015),
              separatorBuilder: (context, index) => sizedboxwithheight(khieght * 0.01),
              itemCount: completeList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(OrderStatus.routename,
                      arguments:
                          OrderArg(orderData: completeList[index], orderId: orderIdlist[index]));
                },
                child: OrderTile(
                  trailing: Text('Trace', style: interbold),
                  imagePath: completeList[index].cartlist!.length < 2
                      ? completeList[index].cartlist![0].imageLink!
                      : cartImage,
                  name: completeList[index].cartlist!.length < 2
                      ? completeList[index].cartlist![0].name!
                      : 'CartOrder${++cartcount}',
                  orderNo: activeListId[index],
                  totalPrice: completeList[index].totalPrice!,
                ),
              ),
            )
          : const Center(child: Text('Currently No Completed Orders'));
    });
  }
}
