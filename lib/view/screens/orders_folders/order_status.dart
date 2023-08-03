import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:order_tracker_zen/order_tracker_zen.dart';
import 'package:provider/provider.dart';
import 'package:time_craft_control/controller/dropdown_controller.dart';
import 'package:time_craft_control/model/argument_models/order_details_arg.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/core/const_datas.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/orders_folders/order_detail.dart';
import 'package:time_craft_control/view/screens/orders_folders/widgets/order_tile.dart';
import 'package:time_craft_control/view/screens/orders_folders/widgets/status/status_change_popup.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key, required this.orderArg});
  final OrderArg orderArg;

  static const String routename = '/Orderstatus';

  @override
  Widget build(BuildContext context) {
    var orderData = orderArg.orderData;
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: const AppbarCom(title: 'ORDER STATUS'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: kwidth * 0.025, vertical: khieght * 0.015),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ORDER ID: ${orderArg.orderId}',
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                sizedboxwithheight(khieght * 0.01),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) => OrderTile(
                    imagePath: orderData.cartlist![index].imageLink!,
                    name: orderData.cartlist![index].name!,
                    varient: orderData.cartlist![index].varient,
                    totalPrice: orderData.cartlist![index].totalprice!,
                    trailing: const SizedBox(),
                  ),
                  separatorBuilder: (ctx, index) => sizedboxwithheight(khieght * 0.01),
                  itemCount: orderData.cartlist!.length,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(black)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(OrderDetails.routename, arguments: orderArg);
                    },
                    child: Text('DETAILS', style: interwhitebold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(kwidth * 0.03),
                  child: OrderTrackerZen(
                    tracker_data: tracker(
                      status: orderData.orderStatus!,
                      orderdate: orderData.orderPlacedDate,
                      shippedDate: orderData.shippingDate,
                      outForDeliveryDate: orderData.outForDeliveryDate,
                      deliveryDate: orderData.deliveryDate,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => ChangeNotifierProvider(
                create: (_) => DropdownController(item: statusList, value: statusList[0]),
                child: StatusChangerPopup(
                  orderID: orderArg.orderId,
                  ctx: context,
                ),
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

  List<TrackerData> tracker({
    required String status,
    required String? orderdate,
    required String? shippedDate,
    required String? outForDeliveryDate,
    required String? deliveryDate,
  }) {
    List<TrackerData> trackerdata = [];

    trackerdata.add(trackerMaker(
        title: 'Order Placed', date: orderdate!, displaytext: 'Your order is placed on'));
    if (shippedDate != 'Not setted') {
      trackerdata.add(trackerMaker(
          title: 'Order Shipped', date: shippedDate!, displaytext: 'Your order is shipped on'));
    }
    if (outForDeliveryDate != 'Not setted') {
      trackerdata.add(trackerMaker(
          title: 'Out For Delivery',
          date: outForDeliveryDate!,
          displaytext: 'Your order is out for delivery on'));
    }
    if (deliveryDate != 'Not setted') {
      trackerdata.add(trackerMaker(
          title: 'Order Delivered',
          date: deliveryDate!,
          displaytext: 'Your order is succussfully delivered'));
    }

    return trackerdata;
  }

  trackerMaker({required String title, required String date, required displaytext}) {
    return TrackerData(
        title: title,
        date: date.substring(0, 10),
        tracker_details: [TrackerDetails(title: displaytext, datetime: date.substring(0, 16))]);
  }
}
