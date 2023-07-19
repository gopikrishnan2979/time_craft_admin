import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_craft_control/controller/banner/banner_adding_controller.dart';
import 'package:time_craft_control/services/firebase/banner_adding.dart';
import 'package:time_craft_control/view/common/widgets/appbar.dart';
import 'package:time_craft_control/view/common/widgets/loading.dart';
import 'package:time_craft_control/view/core/styles.dart';
import 'package:time_craft_control/view/screens/banners/addbanner.dart';
import 'package:time_craft_control/view/screens/brands/add_brands/widgets/image_container.dart';

class Banners extends StatelessWidget {
  Banners({super.key});
  static const String routename = '/Banner';
  final CollectionReference firestore =
      FirebaseFirestore.instance.collection(BannerService.collectionName);
  @override
  Widget build(BuildContext context) {
    int size = 0;
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => BannerAddingController(),
        child: Scaffold(
          appBar: const AppbarCom(title: 'BANNER'),
          body: StreamBuilder(
            stream: firestore.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Loading(),
                );
              }
              size = snapshot.data!.docs.length;
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: kwidth * 0.09, vertical: khieght * 0.01),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: khieght * 0.01),
                    child: Stack(
                      children: [
                        ImageContainer(
                          imagePath: snapshot.data!.docs[index]['image'],
                          height: khieght * 0.22,
                          width: kwidth * 0.85,
                          fromNetwork: true,
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                            ),
                            color: black,
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Color.fromARGB(196, 255, 255, 255))),
                            onPressed: () async {
                              FirebaseStorage.instance
                                  .refFromURL(snapshot.data!.docs[index]['image'])
                                  .delete();
                              await FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                                  myTransaction.delete(snapshot.data!.docs[index].reference);
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data != null ? snapshot.data!.docs.length : 0,
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (size < 5) {
                Navigator.of(context).pushNamed(AddBanner.routename);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Alert'),
                    content: const Text('Maximum limit is 5'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}