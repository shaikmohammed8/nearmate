import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Message {
  final message, date, uid, status;

  Message({this.message, this.date, this.uid, this.status});

  Message fromMap(DocumentSnapshot snap) {
    return Message(
        message: snap['message'],
        date: snap['date'],
        uid: snap['uid'],
        status: snap['status']);
  }

  Map<String, dynamic> toMap(Message message) {
    return {
      'message': message.message,
      'date': message.date,
      'uid': message.uid,
      'status': message.status
    };
  }
}
