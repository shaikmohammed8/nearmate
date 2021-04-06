import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearmate/models/message.dart';

class MessageLayout extends StatelessWidget {
  Message message;
  MessageLayout(this.message);
  @override
  Widget build(BuildContext context) {
    if (message.uid == FirebaseAuth.instance.currentUser.uid) {
      return messageView(
          BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          Get.theme.primaryColor,
          Colors.white);
    } else
      return messageView(
          BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          Colors.white,
          Colors.black);
  }

  Container messageView(
      BorderRadius borderRadius, Color color, Color textcolor) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
        bottom: 5,
        right: 8,
        left: 8,
      ),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 2, top: 2),
      constraints: BoxConstraints(maxWidth: Get.mediaQuery.size.width * 0.6),
      decoration: BoxDecoration(borderRadius: borderRadius, color: color),
      child: Text(
        message.message,
        style: TextStyle(
          color: textcolor,
          fontSize: 18,
        ),
      ),
    );
  }
}
