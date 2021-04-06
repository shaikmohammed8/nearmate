import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nearmate/controller/conversationcontroller.dart';
import 'package:nearmate/models/message.dart';
import 'package:nearmate/models/usermodel.dart';
import 'package:nearmate/screens/chatscrens/messagelayour.dart';
import 'package:nearmate/service/firestore.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  var firestore = FirestoreDB();

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  var _controller = Get.find<ConversationController>();

  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: Colors.grey[400]),
            onPressed: () {
              Get.back();
            },
          ),
          title: StreamBuilder<DocumentSnapshot>(
              stream: FirestoreDB().getuser(args['id']),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(UserModel().fromMap(snapshot.data).name);
                } else
                  return SizedBox();
              }),
          actions: [
            Icon(
              Icons.more_horiz_rounded,
              color: Colors.grey[400],
            )
          ],
        ),
        body: Column(children: [
          StreamBuilder<List<QueryDocumentSnapshot>>(
              stream: firestore.getMessages(
                  FirebaseAuth.instance.currentUser.uid, args["id"]),
              builder: (ctx, snapshot) => snapshot.hasData
                  ? Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data.length + 1,
                        itemBuilder: (_, index) {
                          if (index == snapshot.data.length) {
                            if (snapshot.data.isEmpty) {
                              return Column(
                                children: [
                                  header(),
                                  Text("You dont have any conversation"),
                                  Text("to start a conversation send a message")
                                ],
                              );
                            }
                            return header();
                          }

                          return Wrap(
                              alignment:
                                  Message().fromMap(snapshot.data[index]).uid ==
                                          FirebaseAuth.instance.currentUser.uid
                                      ? WrapAlignment.end
                                      : WrapAlignment.start,
                              children: [
                                MessageLayout(
                                  Message().fromMap(snapshot.data[index]),
                                ),
                              ]);
                        },
                      ),
                    )
                  : Expanded(child: Container())),
          Container(
            color: Colors.white,
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.emoji_emotions,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {}),
                Container(
                  width: Get.size.width * 0.7,
                  child: CupertinoTextField(
                    onChanged: (val) {
                      if (val.trim() == "" || val.isEmpty)
                        _controller.isWriting.value = false;
                      else
                        _controller.isWriting.value = true;
                    },
                    controller: _controller.messageController,
                    cursorColor: Colors.black,
                    placeholder: "Type a message",
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minLines: 1,
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                IconButton(
                    icon: Obx(() => !_controller.isWriting.value
                        ? Icon(
                            Icons.photo,
                            color: Colors.grey[400],
                          )
                        : Icon(
                            Icons.send,
                            color: Get.theme.primaryColor,
                          )),
                    onPressed: () {
                      _controller.sendMessage(args['id']);
                    }),
              ],
            ),
          ),
        ]));
  }

  Widget header() => Center(
        child: Column(
          children: [
            FutureBuilder<DocumentSnapshot>(
                future: firestore.getUserOnce(args['id']),
                builder: (ctx, snap) {
                  if (snap.hasData) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(snap.data[' photo']),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          snap.data['name'],
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  } else
                    return CircularProgressIndicator();
                })
          ],
        ),
      );
}
