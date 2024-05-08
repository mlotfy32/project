import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_app/Screens/SplashViewBody.dart';
import 'package:food_app/Screens/homeBodt.dart';
import 'package:food_app/constant.dart';
import 'package:food_app/holper.dart';
import 'package:food_app/widgets/customeButton.dart';
import 'package:get/get.dart';

class PaymentDetailesView extends StatelessWidget {
  PaymentDetailesView(
      {super.key,
      required this.index,
      required this.peice,
      required this.Totalpeice,
      this.state,
      this.id});

  GlobalKey<FormState> fornkey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final int index;
  final int peice;
  final double Totalpeice;
  var id, state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Center(),
        centerTitle: true,
        title: Text(
          'Payment',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height - 90,
        decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.7)
                ],
                tileMode: TileMode.mirror),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CustomeCredit12(
                autovalidateMode: autovalidateMode,
                formKey: fornkey,
                index: index,
                Totalpeice: Totalpeice,
                peice: peice,
                state: state,
                id: id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var user = FirebaseAuth.instance.currentUser!.uid;

class CustomeCredit12 extends StatefulWidget {
  CustomeCredit12(
      {super.key,
      required this.autovalidateMode,
      required this.formKey,
      required this.index,
      required this.peice,
      required this.Totalpeice,
      this.state,
      this.id});

  final AutovalidateMode autovalidateMode;
  final GlobalKey<FormState> formKey;
  final int index;
  final int peice;
  final double Totalpeice;
  var id, state;
  @override
  State<CustomeCredit12> createState() => _CustomeCreditState();
}

class _CustomeCreditState extends State<CustomeCredit12> {
  @override
  String cardNumber = '', expiryDate = '', cardHolderName = '', cvvCode = '';
  bool showBackView = false;

  CollectionReference order = FirebaseFirestore.instance.collection('Order');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreditCardWidget(
            cardBgColor: Colors.grey,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: showBackView,
            onCreditCardWidgetChange: (value) {},
            isHolderNameVisible: true),
        CreditCardForm(
            autovalidateMode: widget.autovalidateMode,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (CreditCardModel) {
              cardNumber = CreditCardModel.cardNumber;
              expiryDate = CreditCardModel.expiryDate;
              cardHolderName = CreditCardModel.cardHolderName;
              cvvCode = CreditCardModel.cvvCode;
              showBackView = CreditCardModel.isCvvFocused;
              setState(() {});
            },
            formKey: widget.formKey),
        SizedBox(
          height: 60,
        ),
        customeButton(
          title: 'Complete',
          colortext: Colors.white,
          colorBack: Colors.black,
          onTap: () async {
            if (widget.formKey.currentState!.validate()) {
              helper().Loading();
              if (widget.state == 1) {
                await order.add({
                  'order name': foodName[widget.index],
                  'user': user,
                  'peice': widget.peice,
                  'totalPrice': widget.Totalpeice
                });
                Get.snackbar('', '',
                    titleText: Text('Hi'),
                    messageText: Text(
                      'Payment Complete',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    snackStyle: SnackStyle.FLOATING);
                Timer(Duration(seconds: 1), () {
                  Get.offAll(() => homeBody());
                });
              } else {
                order.doc(widget.id).update({
                  'order name': foodName[widget.index],
                  'user': user,
                  'peice': widget.peice,
                  'totalPrice': widget.Totalpeice
                });
                Get.snackbar('', '',
                    titleText: Text('Hi'),
                    messageText: Text(
                      'Order Updated ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    snackStyle: SnackStyle.FLOATING);
                Timer(Duration(seconds: 1), () {
                  Get.offAll(() => homeBody());
                });
              }
            }
          },
        )
      ],
    );
  }
}
