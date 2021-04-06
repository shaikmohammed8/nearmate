import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:decorated_icon/decorated_icon.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Get.theme.primaryColor,
        padding: EdgeInsets.only(left: 16, right: 16, top: 120, bottom: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DecoratedIcon(
              Icons.near_me,
              color: Colors.white,
              size: 80,
              shadows: [
                BoxShadow(
                    blurRadius: 6,
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(6, 12))
              ],
            ),
            Text(
              "NearMeet",
              style: Get.theme.textTheme.headline1.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                //fontFamily: GoogleFonts.gaegu().fontFamily
              ),
            ),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/login");
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Get.theme.primaryColor),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: Colors.white,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/signup');
              },
              child: Text(
                "SignUp",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: Get.theme.primaryColor,
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(30))),
            )
          ],
        ),
      ),
    );
  }
}
