import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nearmate/screens/mainscreens/bottomnavigationscreen.dart';
import 'package:nearmate/service/authentication.dart';
import 'package:nearmate/utils.dart';

class LoginController extends GetxController {
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }

  void login(String email, String password) async {
    Utils.showdialog();
    try {
      await Authetication().login(email: email, password: password);
      print(email);

      if (Get.isDialogOpen) Get.back();
      Get.to(() => BottomNavigationScreen());
    } on FirebaseAuthException catch (e) {
      if (Get.isDialogOpen) {
        Get.back();
      }
      Utils.showErrorDialog(e.message);
    }
  }
}
