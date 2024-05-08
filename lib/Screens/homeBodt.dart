import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/Screens/FoodFetailes.dart';
import 'package:food_app/Screens/cridetCard.dart';
import 'package:food_app/constant.dart';
import 'package:food_app/widgets/grigViewBody.dart';
import 'package:get/get.dart';
import 'package:food_app/Screens/orders.dart';

class homeBody extends StatelessWidget {
  homeBody({super.key});

  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white38,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            'Menue',
            style: TextStyle(color: Colors.white),
          ),
        ),
        drawer: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => getorders());
                },
                child: Container(
                  width: 150,
                  child: Center(
                    child: Text(
                      'Your Orders',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white24),
                ),
              )
            ],
          ),
          height: MediaQuery.sizeOf(context).height * 0.9,
          width: MediaQuery.sizeOf(context).width * 0.55,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.black12, Colors.white],
                  tileMode: TileMode.mirror),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.black45, Colors.black26],
                  tileMode: TileMode.mirror),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15))),
          child: GridView.builder(
              itemCount: foodName.length + 3,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 0.1),
              itemBuilder: (context, index) => gridViewBody(index: index)),
        ));
  }
}
