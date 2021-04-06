import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearmate/screens/wizardsScreens/firstwizard.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings"),
      ),
      body: ElevatedButton(
        child: Text("log out"),
        onPressed: () async {
          await FirebaseAuth.instance
              .signOut()
              .then((value) => Get.offAll(() => FirstWizard()));
        },
      ),
    );
  }
}
