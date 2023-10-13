import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_craft_control/controller/brand_image_provider/brand_image_provider.dart';
import 'package:time_craft_control/services/firebase/banner_service.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/common/widgets/notification_widgets.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/brands/add_brands/widgets/image_container.dart';

class AddBanner extends StatelessWidget {
  const AddBanner({super.key});

  static const String routename = '/Addbanner';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const AppbarCom(
          title: 'ADD BANNER',
        ),
        body: SizedBox(
          height: khieght * 0.4,
          child: Center(
            child: ChangeNotifierProvider(
              create: (context) => BrandImageProvider(),
              child: Consumer<BrandImageProvider>(
                builder: (context, brandimagecontroller, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        brandimagecontroller.addImage();
                      },
                      child: ImageContainer(
                        imagePath: brandimagecontroller.imagePath,
                        height: khieght * 0.22,
                        width: kwidth * 0.85,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (brandimagecontroller.imagePath != null) {
                          loading(context);
                          String? error = await BannerService().addBanner(
                            context: context,
                            imagepath: brandimagecontroller.imagePath!,
                          );
                          if (context.mounted) {
                            Navigator.of(context).pop();
                            if (error == null) {
                              String addedmessage = 'Banner added successfully';
                              snackBarDesign(text: addedmessage, color: addingColor);
                              Navigator.of(context).pop();
                            } else {
                              alertshower(text: error, context: context);
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(
                          Size(kwidth * 0.43, khieght * 0.05),
                        ),
                        backgroundColor: const MaterialStatePropertyAll(black),
                        foregroundColor: const MaterialStatePropertyAll(white),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kwidth * 0.0225),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.add),
                          Text('Add Banner', style: interwhitebold),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
