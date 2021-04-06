import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearmate/screens/mainscreens/bottomnavigationscreen.dart';
import 'package:nearmate/screens/wizardsScreens/firstwizard.dart';

class AuthHandler extends GetWidget<AuthHandleController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      builder: (_) {
        if (Get.find<AuthHandleController>().isLoggedin.value) {
          return BottomNavigationScreen();
        } else
          return FirstWizard();
      },
    );
  }
}

class AuthHandleController extends GetxController {
  var isLoggedin = false.obs;

  @override
  void onReady() {
    super.onReady();

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        isLoggedin.value = false;
      } else {
        isLoggedin.value = true;
      }
    });
  }
}
