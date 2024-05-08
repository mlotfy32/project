import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/Screens/homeBodt.dart';
import 'package:food_app/Screens/login.dart';
import 'package:food_app/constant.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

var user = FirebaseAuth.instance.currentUser;

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<splashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    NavigatetoHomeView();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              builder: (context, _) => SlideTransition(
                  position: slidingAnimation,
                  child: Image.asset(
                    'assets/foodlogo.png',
                    width: 300,
                    height: 250,
                  )),
              animation: slidingAnimation,
            ),
            AnimatedBuilder(
              builder: (context, _) => SlideTransition(
                position: slidingAnimation,
                child: Text(
                  style: Text_Style.splashFont,
                  'Get Your Favoeit Dish',
                  textAlign: TextAlign.center,
                ),
              ),
              animation: slidingAnimation,
            ),
          ],
        ),
      ),
    );
  }

  void initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }

  void NavigatetoHomeView() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(() => login(),
          //homeBody(),
          transition: Transition.downToUp,
          duration: Duration(seconds: 2));
    });
  }
}
