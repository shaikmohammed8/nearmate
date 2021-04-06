import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nearmate/screens/mainscreens/bottomnavigationscreen.dart';
import 'package:nearmate/service/authentication.dart';
import '../utils.dart';

class SignupController extends GetxController {
  void signup(String email, String passs, String name) async {
    Utils.showdialog();
    try {
      await Authetication().signup(email: email, password: passs, name: name);
      if (Get.isDialogOpen) Get.back();
      Get.to(() => BottomNavigationScreen());
    } on FirebaseAuthException catch (e) {
      if (Get.isDialogOpen) {
        Get.back();
      }
      Utils.showErrorDialog(e.message);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
