import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_craft_control/model/argument_models/order_details_arg.dart';
import 'package:time_craft_control/model/firebase_instance_model.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';
import 'package:time_craft_control/view/core/styles.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.orderArg});
  final OrderArg orderArg;
  static const String routename = '/Orderdetails';

  @override
  Widget build(BuildContext context) {
    var orderdata = orderArg.orderData;
    var cartList = orderdata.cartlist;

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: const AppbarCom(title: 'ORDER DETAILS'),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kwidth * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedboxwithheight(khieght * 0.01),
              Text(
                'Order No : ${orderArg.orderId}',
                style: GoogleFonts.inter(fontSize: kwidth * 0.04, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: khieght * 0.578,
                child: PageView.builder(
                  itemCount: cartList!.length,
                  itemBuilder: (context, index) {
                    var cartdata = orderdata.cartlist![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: khieght * 0.4,
                            width: kwidth * 0.97,
                            child:
                                Image.network(cartList[index].imageLink!, fit: BoxFit.fitHeight)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: kwidth * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedboxwithheight(khieght * 0.01),
                              textinter('Name : ${cartdata.name}'),
                              sizedboxwithheight(khieght * 0.01),
                              textinter('Price : ₹ ${cartdata.price}'),
                              sizedboxwithheight(khieght * 0.01),
                              textinter('Varient : ₹ ${cartdata.varient}'),
                              sizedboxwithheight(khieght * 0.01),
                              textinter('Quantity :  ${cartdata.quantity}'),
                              sizedboxwithheight(khieght * 0.01),
                              textinter('Net Worth Total Price : ₹${cartdata.totalprice}'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kwidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textinter('Gross Worth Total Price : ₹${orderdata.totalPrice}'),
                    const Divider(),
                    sizedboxwithheight(khieght * 0.01),
                    textinter('Shipping Address :'),
                    sizedboxwithheight(khieght * 0.01),
                    Card(
                      elevation: 5,
                      child: Container(
                        width: kwidth * 0.97,
                        padding: EdgeInsets.symmetric(
                            horizontal: kwidth * 0.06, vertical: khieght * 0.01),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(kwidth * 0.02),
                            color: Colors.blue[100]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textinter('${orderdata.address!.localAddress},'),
                            textinter('${orderdata.address!.city},${orderdata.address!.district},'),
                            textinter('${orderdata.address!.state},'),
                            textinter('Pin:${orderdata.address!.pincode}'),
                            orderdata.address!.landmark != 'no landmark'
                                ? textinter('landmark:${orderdata.address!.landmark}')
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    sizedboxwithheight(khieght * 0.01),
                    StreamBuilder(
                      stream: FirebaseInstanceModel.user.doc(orderdata.userid).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Loading();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textinter('Name : ${snapshot.data!["name"]}'),
                            sizedboxwithheight(khieght * 0.01),
                            textinter('Gmail: ${snapshot.data!["email"]}'),
                            sizedboxwithheight(khieght * 0.01),
                            textinter('phone : ${orderdata.phone}'),
                          ],
                        );
                      },
                    ),
                    sizedboxwithheight(khieght * 0.01),
                    textinter(
                      orderdata.israzorpay! ? 'Payment Mode: Razorpay' : 'Payment Mode: COD',
                    ),
                    sizedboxwithheight(khieght * 0.01),
                    textinter('Payment ID: ${orderdata.paymentId}'),
                    sizedboxwithheight(khieght * 0.01),
                    textinter('Order Placed On : ${orderdata.orderPlacedDate!.substring(0, 10)}'),
                    sizedboxwithheight(khieght * 0.01),
                    textinter('Order Status : ${orderdata.orderStatus}'),
                    sizedboxwithheight(khieght * 0.05)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textinter(String text) {
    return Text(
      text,
      style: interbold,
    );
  }
}
