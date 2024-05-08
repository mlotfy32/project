import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class helper {
  Loading() {
    Get.dialog(Container(
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.deepPurple,
          size: 100,
        ),
      ),
    ));
  }

  error({required String error}) {
    Get.defaultDialog(
        title: 'Oops',
        content: Container(
          child: Center(
            child: Text('$error'),
          ),
        ));
  }
}
