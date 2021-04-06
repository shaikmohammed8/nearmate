import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearmate/screens/wizardsScreens/thirdwzard.dart';
import 'package:swipedetector/swipedetector.dart';

class SecondWizard extends StatelessWidget {
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
                "Start chat",
                style: Get.theme.textTheme.headline1,
              ),
              SwipeDetector(
                onSwipeRight: () => Get.back(),
                onSwipeLeft: () =>
                    Get.to(ThirdWizard(), transition: Transition.topLevel),
                child: Container(
                    height: 400,
                    child: Image.asset(
                      "assets/images/middle.jpg",
                    )),
              ),
              Text("you can send message to anyone who is showing on map."),
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
                    backgroundColor: Get.theme.primaryColor,
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
