import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';

class Utils {
  static showErrorDialog(String msg) {
    showModal(
        context: Get.context,
        configuration: FadeScaleTransitionConfiguration(),
        builder: (_) => SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                children: [
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Image.asset(
                            "assets/images/error.jpg",
                            scale: 5,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(msg)
                      ],
                    ),
                  ),
                ]));
  }

  static showdialog() {
    showModal(
        context: Get.context,
        builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Please Wait",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        color: Colors.white,
                        child: CircularProgressIndicator()),
                    SizedBox(
                      height: 10,
                    ),
                    Text("this will not take much time")
                  ],
                ),
              ),
            ));
  }
}
