import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/Screens/cridetCard.dart';
import 'package:food_app/constant.dart';
import 'package:food_app/widgets/customeButton.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class FoodFetailes extends StatefulWidget {
  FoodFetailes(
      {super.key,
      required this.index,
      required this.state,
      this.peice,
      this.id,
      this.totalPrice});
  final int index;
  final int state;
  var peice, totalPrice, id;
  @override
  State<FoodFetailes> createState() => _FoodFetailesState();
}

class _FoodFetailesState extends State<FoodFetailes> {
  CollectionReference getOrders =
      FirebaseFirestore.instance.collection('Order');
  double val = 1;
  String total = '1';
  int peice = 1;
  @override
  Widget build(BuildContext context) {
    widget.state == 1 ? 1 : 2;
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 10),
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
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              widget.state == 2 ? 'Edite Order' : 'Order Detailes',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.state == 2 ? '' : 'Peice price ${foodPrice[0]}\$',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 50,
            ),
            Image.asset('assets/food.png'),
            SizedBox(
              height: 140,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 240,
                    child: Slider(
                        value: val!,
                        min: 1,
                        max: 30,
                        divisions: 30,
                        label: '${val!.toInt()}',
                        onChanged: (Value) {
                          setState(() {
                            val = Value;
                            total =
                                'Total price ${foodPrice[0] * val!.toInt()}';
                            peice = Value.toInt();
                          });
                          print(val!.toInt());
                        }),
                  ),
                  Text(
                    widget.state == 1
                        ? '${val!.toInt()} Peice'
                        : peice == 1
                            ? '${widget.peice} Peice'
                            : '${val!.toInt()} Peice',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.state == 1
                  ? 'Total price ${foodPrice[0] * val!.toInt()}\$'
                  : total == '1'
                      ? 'Total price ${widget.totalPrice}'
                      : 'Total price ${foodPrice[0] * val!.toInt()}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            customeButton(
              title: 'Go to card',
              colortext: Colors.white,
              colorBack: Colors.black,
              onTap: () {
                Get.to(() => PaymentDetailesView(
                      state: widget.state,
                      id: widget.id,
                      index: widget.index,
                      Totalpeice: foodPrice[0] * val!.toInt(),
                      peice: val!.toInt(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
