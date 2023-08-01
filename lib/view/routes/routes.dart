import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_craft_control/controller/order_scrn_controller.dart';
import 'package:time_craft_control/controller/product/add_product_image_controller/product_image_controller.dart';
import 'package:time_craft_control/controller/product/color_adding_controller/color_varient_adding_controller.dart';
import 'package:time_craft_control/model/argument_models/order_details_arg.dart';
import 'package:time_craft_control/model/argument_models/product_arg.dart';
import 'package:time_craft_control/view/screens/banners/addbanner.dart';
import 'package:time_craft_control/view/screens/banners/banners.dart';
import 'package:time_craft_control/view/screens/brands/add_brands/add_brand.dart';
import 'package:time_craft_control/view/screens/product/add_product/add_product.dart';
import 'package:time_craft_control/view/screens/brands/all_brands/all_brands.dart';
import 'package:time_craft_control/view/screens/allproduct_and_brandproduct/product_listing.dart';
import 'package:time_craft_control/view/screens/home/home.dart';
import 'package:time_craft_control/view/screens/orders_folders/order_detail.dart';
import 'package:time_craft_control/view/screens/orders_folders/order_status.dart';
import 'package:time_craft_control/view/screens/orders_folders/orders_screen.dart';
import 'package:time_craft_control/view/screens/product/product_view/product_view.dart';
import 'package:time_craft_control/view/screens/splashscreen/splashscreen.dart';

class RouteProvider {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //Splash Screen route
      case SplashScreen.routename:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      //Myhome route
      case MyHome.routename:
        return MaterialPageRoute(builder: (context) => const MyHome());

      //Product route
      case ProductList.routefromhome:
        return MaterialPageRoute(
            builder: (context) => const ProductList(
                  title: ProductList.routefromhome,
                  isFromBrand: false,
                ));
      case ProductList.routefrombrands:
        return MaterialPageRoute(
            builder: (context) => const ProductList(
                  title: ProductList.routefrombrands,
                  isFromBrand: true,
                ));
      case AllBrands.routename:
        return MaterialPageRoute(builder: (context) => const AllBrands());
      case AddBrand.routename:
        return MaterialPageRoute(builder: (context) => const AddBrand());
      case AddProduct.routename:
        return MaterialPageRoute(
            builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (context) => ProductImageController()),
                    ChangeNotifierProvider(create: (context) => VarientAddingController())
                  ],
                  child: const AddProduct(),
                ));
      case Orders.routename:
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => OrderScrnController(), child: const Orders()));
      case OrderStatus.routename:
        return MaterialPageRoute(builder: (context) {
          final arg = routeSettings.arguments as OrderArg;
          return OrderStatus(
            orderArg: arg,
          );
        });
      case Banners.routename:
        return MaterialPageRoute(builder: (context) => Banners());
      case AddBanner.routename:
        return MaterialPageRoute(builder: (context) => const AddBanner());
      case OrderDetails.routename:
        return MaterialPageRoute(builder: (context) {
          final arg = routeSettings.arguments as OrderArg;
          return OrderDetails(orderArg: arg);
        });
      case ProductView.routename:
        return MaterialPageRoute(builder: (context) {
          final arg = routeSettings.arguments as ProductArgument;
          return ProductView(productDataO: arg);
        });
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(builder: (ctx) {
      return const Scaffold(
        body: Center(
          child: Text('Something Error'),
        ),
      );
    });
  }
}
