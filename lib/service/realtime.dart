import 'package:firebase_database/firebase_database.dart';

class RealtimeDB {
  void addUserLocation({lat, lang, uid}) {
    FirebaseDatabase.instance
        .reference()
        .child("userlocations")
        .child(uid)
        .set({'lat': lat, 'lang': lang, 'uid': uid}).asStream();
  }

  Stream<Event> readUserLocation() {
    var val =
        FirebaseDatabase.instance.reference().child("userlocations").onValue;

    return val;
  }

  Future<DataSnapshot> getUserLocation(String uid) {
    return FirebaseDatabase.instance
        .reference()
        .child("userlocations")
        .child(uid)
        .once();
  }
  // Future<Void> sendMessage(String cuid, String ruid, Message message) async {
  //   await FirebaseDatabase.instance
  //       .reference()
  //       .child("message")
  //       .child(cuid)
  //       .child(ruid)
  //       .push()
  //       .set(message.toMap(message));

  //   await FirebaseDatabase.instance
  //       .reference()
  //       .child("message")
  //       .child(ruid)
  //       .child(cuid)
  //       .push()
  //       .set(message.toMap(message));
  // }

  // Stream<DataSnapshot> getMeassages({String uid, String ruid}) {
  //   var rsult = FirebaseDatabase.instance
  //       .reference()
  //       .child("message")
  //       .child(uid)
  //       .child(ruid)
  //       .orderByKey()
  //       .onValue
  //       .map((event) => event.snapshot);
  //   rsult.listen((event) {
  //     event.value.forEach((_, value) {
  //       print(value);
  //     });
  //   });
  //   return rsult;
  // }
}
