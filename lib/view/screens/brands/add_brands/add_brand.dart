import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_craft_control/controller/brand_image_provider/brand_image_provider.dart';
import 'package:time_craft_control/model/brand_model.dart';
import 'package:time_craft_control/services/firebase/brand_service.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/common/widgets/notification_widgets.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/brands/add_brands/widgets/add_brand_textfield.dart';
import 'package:time_craft_control/view/screens/brands/add_brands/widgets/image_container.dart';

class AddBrand extends StatefulWidget {
  const AddBrand({super.key});
  static const String routename = '/Addbrand';

  @override
  State<AddBrand> createState() => _AddBrandState();
}

class _AddBrandState extends State<AddBrand> {
  final TextEditingController _brandNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _brandNameController.dispose();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: const AppbarCom(title: 'ADD BRAND'),
          body: Padding(
            padding: EdgeInsets.all(kwidth * 0.05),
            child: SizedBox(
              height: khieght * 0.5,
              child: ChangeNotifierProvider(
                create: (context) => BrandImageProvider(),
                child: Consumer<BrandImageProvider>(
                  builder: (context, brandimagecontroller, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          brandimagecontroller.addImage();
                        },
                        child: ImageContainer(
                          imagePath: brandimagecontroller.imagePath,
                          height: khieght * 0.2,
                          width: kwidth * 0.95,
                        ),
                      ),
                      AddBrandTextField(controller: _brandNameController),
                      ElevatedButton(
                        onPressed: () async {
                          final RegExp nameRegExp = RegExp('[a-zA-Z]');
                          if (brandimagecontroller.imagePath != null &&
                              _brandNameController.text.trim() != '' &&
                              nameRegExp.hasMatch(_brandNameController.text.trim())) {
                            BrandModel branddata = BrandModel(
                                imagepath: brandimagecontroller.imagePath!,
                                name: _brandNameController.text.trim());
                            loading(context);
                            String? error = await BrandServices()
                                .addToBrandCollection(brandModel: branddata, context: context);
                            if (context.mounted) {
                              Navigator.of(context).pop();
                              if (error == null) {
                                snackBarDesign(
                                    text: 'Brand added successfully', color: addingColor);
                                Navigator.of(context).pop();
                              } else {
                                alertshower(text: error, context: context);
                              }
                            }
                          } else {
                            alertshower(text:'Brand name and Image is required',context: context);
                          }
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(kwidth * 0.43, khieght * 0.05)),
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
                            Text('Add Brand', style: interwhitebold),
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
      ),
    );
  }
}
