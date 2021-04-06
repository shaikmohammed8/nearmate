import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearmate/screens/wizardsScreens/second_wizard.dart';
import 'package:swipedetector/swipedetector.dart';

class FirstWizard extends StatelessWidget {
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
                "Find Near",
                style: Get.theme.textTheme.headline1,
              ),
              SwipeDetector(
                onSwipeLeft: () =>
                    Get.to(SecondWizard(), transition: Transition.topLevel),
                child: Container(
                    height: 400,
                    child: Image.asset(
                      "assets/images/first.jpg",
                    )),
              ),
              Text(
                  "this app will show you all people that are using this app."),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Theme.of(context).primaryColor,
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
