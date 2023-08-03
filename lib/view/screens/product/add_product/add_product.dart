import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_craft_control/controller/product/add_product_image_controller/product_image_controller.dart';
import 'package:time_craft_control/controller/product/color_adding_controller/color_varient_adding_controller.dart';
import 'package:time_craft_control/controller/dropdown_controller.dart';
import 'package:time_craft_control/model/product_model.dart';
import 'package:time_craft_control/services/firebase/product_services.dart';
import 'package:time_craft_control/services/validator/validator_product.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/common_textfield.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/drop_down_widget.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/image_part/image_adding_containers.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/image_part/image_shower.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/textfield_details.dart';
import 'package:time_craft_control/view/screens/product/add_product/widgets/varients/varient_part.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  static const String routename = '/Addproduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _smallDiscriptionController = TextEditingController();

  final TextEditingController _discriptionController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _discountController = TextEditingController();

  final CollectionReference brands = FirebaseFirestore.instance.collection('brands');

  final List<String> typeitem = [
    'Select type',
    'Analog',
    'Digital',
  ];

  final List<String> waterResistant = [
    'Select whether water resistant',
    'No',
    'Yes',
  ];

  final List<String> gender = ['All', 'Men', 'Women', 'Kid'];

  final ProductModel _productdata = ProductModel();

  final List<String> brandlist = [
    'Select Brand',
  ];

  final Map<String, String> brandDocID = {};

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppbarCom(title: 'ADD PRODUCT'),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: kwidth * 0.05),
          child: StreamBuilder(
              stream: brands.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No brands were added',
                      style: interbold,
                    ),
                  );
                }
                for (QueryDocumentSnapshot<Object?> brand in snapshot.data!.docs) {
                  if (!brandlist.contains(brand['name'])) {
                    brandlist.add(brand['name']);
                    brandDocID[brand['name']] = brand.id;
                  }
                }

                return ListView(
                  children: [
                    sizedboxwithheight(khieght * 0.04),
                    Consumer<ProductImageController>(
                        builder: (context, productImagecontroller, child) {
                      _productdata.imagelist = productImagecontroller.imagelist;
                      return Column(
                        children: [
                          ImageShower(imageController: productImagecontroller),
                          sizedboxwithheight(khieght * 0.04),
                          ImageAddingContainers(
                            productImagecontroller: productImagecontroller,
                          ),
                        ],
                      );
                    }),
                    sizedboxwithheight(khieght * 0.04),
                    TextFieldDetails(
                        discriptionController: _discriptionController,
                        smallDiscriptionController: _smallDiscriptionController,
                        nameController: _nameController),
                    sizedboxwithheight(khieght * 0.02),
                    Text('Brand', style: interbold),
                    ChangeNotifierProvider(
                        create: (context) =>
                            DropdownController(item: brandlist, value: brandlist[0]),
                        child: Consumer<DropdownController>(
                            builder: (context, DropdownController controller, child) {
                          _productdata.brand = controller.value == controller.item[0]
                              ? ''
                              : brandDocID[controller.value] ?? '';
                          return DropDownProductAdd(
                            dropDownController: controller,
                          );
                        })),
                    Text('Details', style: interbold),
                    ChangeNotifierProvider(
                      create: (context) => DropdownController(item: typeitem, value: typeitem[0]),
                      child: Consumer<DropdownController>(
                          builder: (context, DropdownController controller, child) {
                        _productdata.type =
                            controller.value == controller.item[0] ? '' : controller.value;
                        return DropDownProductAdd(
                          dropDownController: controller,
                        );
                      }),
                    ),
                    ChangeNotifierProvider(
                      create: (context) =>
                          DropdownController(item: waterResistant, value: waterResistant[0]),
                      child: Consumer<DropdownController>(
                          builder: (context, DropdownController controller, child) {
                        _productdata.waterResistantType =
                            controller.value == controller.item[0] ? '' : controller.value;
                        return DropDownProductAdd(
                          dropDownController: controller,
                        );
                      }),
                    ),
                    ChangeNotifierProvider(
                      create: (context) => DropdownController(item: gender, value: gender[0]),
                      child: Consumer<DropdownController>(
                          builder: (context, DropdownController controller, child) {
                        _productdata.gender = controller.value;
                        return DropDownProductAdd(
                          dropDownController: controller,
                        );
                      }),
                    ),
                    sizedboxwithheight(khieght * 0.02),
                    TextFieldCom(
                        label: 'Price',
                        keyboardtype: TextInputType.number,
                        controller: _priceController),
                    sizedboxwithheight(khieght * 0.02),
                    TextFieldCom(
                      label: 'Discount in %',
                      keyboardtype: TextInputType.number,
                      controller: _discountController,
                    ),
                    sizedboxwithheight(khieght * 0.02),
                    Consumer(builder: (context, VarientAddingController controller, child) {
                      _productdata.varients = controller.varients;
                      return VarientContainer(
                        varientController: controller,
                      );
                    }),
                    sizedboxwithheight(khieght * 0.02),
                    addproduct(context),
                    sizedboxwithheight(khieght * 0.02),
                  ],
                );
              }),
        ),
      ),
    );
  }

  Widget addproduct(BuildContext context,) {
    return ElevatedButton(
      onPressed: () {
        _productdata.name = _nameController.text.trim();
        _productdata.discription = _discriptionController.text.trim();
        _productdata.stringprice = _priceController.text.trim();
        _productdata.stringdiscount = _discountController.text.trim();
        _productdata.smalldiscription = _smallDiscriptionController.text.trim();
        Validation validation = Validation(product: _productdata, context: context);
        if (validation.validation()) {
          ProductServices().addToProductCollection(product: _productdata, context: context);
        }
      },
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(kwidth * 0.9, khieght * 0.06)),
        backgroundColor: const MaterialStatePropertyAll(black),
        foregroundColor: const MaterialStatePropertyAll(white),
        shape: const MaterialStatePropertyAll(
          ContinuousRectangleBorder(),
        ),
      ),
      child: Text(
        'ADD PRODUCT',
        style: interwhitebold,
      ),
    );
  }
}
