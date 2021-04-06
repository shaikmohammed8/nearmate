import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearmate/screens/wizardsScreens/homescreen.dart';
import 'package:swipedetector/swipedetector.dart';

class ThirdWizard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 8.0, right: 8, bottom: 12, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Let's meet",
                style: Get.theme.textTheme.headline1,
              ),
              SwipeDetector(
                onSwipeRight: () => Get.back(),
                onSwipeLeft: () => Get.to(() => HomeScreen()),
                child: Container(
                    height: 400,
                    child: Image.asset(
                      "assets/images/last.jpg",
                      fit: BoxFit.cover,
                    )),
              ),
              Text(
                  "after chatting with them if you like each other! great you can meet."),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Get.theme.primaryColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.grey,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
