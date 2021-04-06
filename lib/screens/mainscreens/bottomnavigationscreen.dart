import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import 'package:get/get.dart';
import 'package:nearmate/screens/mainscreens/chatscreen.dart';
import 'package:nearmate/screens/mainscreens/mapscreen.dart';
import 'package:nearmate/screens/mainscreens/profilescreen.dart';
import 'package:nearmate/screens/mainscreens/settingsscreen.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  var index = 0;
  var screens = [MapScreen(), ChatScren(), ProfileScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (index == 0) {
        //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      }
    });
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: CustomNavigationBar(
          iconSize: 27,
          strokeColor: Get.theme.primaryColor,
          selectedColor: Get.theme.primaryColor,
          isFloating: true,
          borderRadius: Radius.circular(30),
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
          currentIndex: index,
          items: [
            CustomNavigationBarItem(
                icon: Icon(
                  Icons.map_outlined,
                  color: Colors.grey[400],
                  size: 24,
                ),
                selectedIcon: Icon(Icons.map)),
            CustomNavigationBarItem(
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.grey[400],
                  size: 24,
                ),
                selectedIcon: Icon(Icons.chat_bubble)),
            CustomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.grey[400],
                  size: 24,
                ),
                selectedIcon: Icon(Icons.person)),
            CustomNavigationBarItem(
                icon: Icon(
                  Icons.settings_applications_outlined,
                  color: Colors.grey[400],
                  size: 24,
                ),
                selectedIcon: Icon(Icons.settings_applications)),
          ],
        ),
      ),
    );
  }
}
