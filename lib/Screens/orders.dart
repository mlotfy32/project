import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/Screens/FoodFetailes.dart';
import 'package:food_app/widgets/customeButton.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';

class getorders extends StatelessWidget {
  getorders({super.key});
  var user = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    CollectionReference getOrders =
        FirebaseFirestore.instance.collection('Order');
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.5)
                  ],
                  tileMode: TileMode.mirror),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          height: MediaQuery.sizeOf(context).height,
          child: StreamBuilder(
            stream: getOrders.where('user', isEqualTo: user).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            AwesomeDialog(
                                dialogType: DialogType.warning,
                                context: context,
                                body: Container(
                                  width: 400,
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      customeButton(
                                          title: 'Delete',
                                          onTap: () {
                                            Get.back();
                                          },
                                          colortext: Colors.white,
                                          colorBack: Colors.red),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      customeButton(
                                        title: 'Edite',
                                        colortext: Colors.white,
                                        colorBack: Colors.blue,
                                        onTap: () {
                                          Get.to(() => FoodFetailes(
                                                index: index,
                                                state: 2,
                                                id: snapshot
                                                    .data!.docs[index].id,
                                                peice: snapshot
                                                    .data!.docs[index]
                                                    .get('peice'),
                                                totalPrice: snapshot
                                                    .data!.docs[index]
                                                    .get('totalPrice'),
                                              ));
                                        },
                                      )
                                    ],
                                  ),
                                )).show();
                          },
                          child: Container(
                            child: ListTile(
                              leading: Text(
                                '${index + 1}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              title: Text(
                                '${snapshot.data!.docs[index].get('order name')} ${snapshot.data!.docs[index].get('peice')} Peice',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ));
              }
              return Center(
                child: LoadingAnimationWidget.threeRotatingDots(
                  color: Colors.blue,
                  size: 100,
                ),
              );
            },
          )),
    );
  }
}
