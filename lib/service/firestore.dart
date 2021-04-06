import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nearmate/models/message.dart';
import 'package:nearmate/models/usermodel.dart';

class FirestoreDB {
  var userRef = FirebaseFirestore.instance.collection("users");
  var messageRef = FirebaseFirestore.instance.collection("message");

  void adduser(UserModel user) async {
    await userRef.doc(user.id).set(user.toMap(user));
  }

  Stream<DocumentSnapshot> getuser(String uid) {
    return userRef.doc(uid).snapshots();
  }

  Future<DocumentSnapshot> getUserOnce(String uid) async {
    return await userRef.doc(uid).get();
  }

  Future<void> uploadMessage(
      String senderUid, String recieverUid, Message msg) async {
    await messageRef
        .doc(senderUid)
        .collection(recieverUid)
        .doc()
        .set(msg.toMap(msg));
    await messageRef
        .doc(recieverUid)
        .collection(senderUid)
        .doc()
        .set(msg.toMap(msg));
  }

  Stream<QueryDocumentSnapshot> fetchLastMessageBetween({
    @required String senderId,
    @required String receiverId,
  }) =>
      messageRef
          .doc(senderId)
          .collection(receiverId)
          .orderBy("date")
          .snapshots()
          .map((event) => event.docs.last);

  Stream<List<QueryDocumentSnapshot>> getMessages(String sUid, String rUid) =>
      messageRef
          .doc(sUid)
          .collection(rUid)
          .orderBy("date", descending: true)
          .snapshots()
          .map((event) => event.docs);
}
