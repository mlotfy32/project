import 'package:flutter/material.dart';
import 'package:food_app/Screens/FoodFetailes.dart';
import 'package:food_app/constant.dart';
import 'package:get/get.dart';

class gridViewBody extends StatelessWidget {
  const gridViewBody({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => FoodFetailes(
              index: index,
              state: 1,
            ));
      },
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          margin: EdgeInsets.only(top: 60),
          height: 150,
          width: 180,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(blurRadius: 60, spreadRadius: 0, offset: Offset(5, 2))
          ]),
          child: Card(
            color: Colors.black12,
            elevation: 10,
            child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 13),
                  child: Text(
                    '${foodName[0]}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                )),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          width: 160,
          height: 110,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/food.png'), fit: BoxFit.fill)),
        )
      ]),
    );
  }
}
