import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final name, email, photo, id, deviceToken;

  UserModel({this.name, this.id, this.email, this.photo, this.deviceToken});

  Map<String, dynamic> toMap(UserModel user) {
    return {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      ' photo': user.photo,
      'deviceToken': user.deviceToken
    };
  }

  UserModel fromMap(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      photo: doc[' photo'],
      deviceToken: doc['deviceToken'],
    );
  }
}
