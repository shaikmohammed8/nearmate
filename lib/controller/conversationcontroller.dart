import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:nearmate/models/message.dart';
import 'package:nearmate/service/firestore.dart';
import 'package:nearmate/service/realtime.dart';

class ConversationController extends GetxController {
  var messageController = TextEditingController();
  var firstore = FirestoreDB();
  var isWriting = false.obs;

  void sendMessage(ruid) async {
    await firstore.uploadMessage(
        FirebaseAuth.instance.currentUser.uid,
        ruid,
        Message(
            message: messageController.value.text,
            date: DateTime.now().toString(),
            uid: FirebaseAuth.instance.currentUser.uid,
            status: 1));
    isWriting.value = false;
    messageController.clear();
  }
}
