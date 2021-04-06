import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nearmate/models/usermodel.dart';
import 'package:nearmate/service/firestore.dart';
import 'package:nearmate/service/realtime.dart';

class MapController extends GetxController {
  Rx<GoogleMapController> mapController = Rx<GoogleMapController>();
  Rx<LocationData> locationdata = Rx<LocationData>();
  RxSet<Marker> markers = RxSet<Marker>();
  GlobalKey iconKey = GlobalKey();
  var latitude = 0.0.obs;
  var longnitude = 0.0.obs;
  Rx<LocationData> location;
  var showMap = false.obs;
  var ismapLoading = true.obs;

  @override
  void onInit() {
    // getlocation();
    locationdata.bindStream(Location().onLocationChanged);
    locationdata.listen((postion) async {
      if (locationdata.value != null) {
        latitude.value = postion.latitude;
        longnitude.value = postion.longitude;
        RealtimeDB().addUserLocation(
            lat: postion.latitude,
            lang: postion.longitude,
            uid: FirebaseAuth.instance.currentUser.uid);
      }
    });
    paint();
    userLocation();
    super.onInit();
  }

  userLocation() {
    RealtimeDB().readUserLocation().listen((event) {
      print(event.snapshot.value.toString());
      event.snapshot.value.forEach((keys, values) async {
        print(keys);
        markers.add(Marker(
          markerId: MarkerId(values['uid']),
          position: LatLng(
            values['lat'],
            values['lang'],
          ),
          onTap: () async {
            Get.bottomSheet(userBottomSheet(await title(values['uid'])));
          },
          //   infoWindow: InfoWindow(title: await title(event)),
          icon: await getMarkerIcon(Size(150, 150),
              await title(values['uid']).then((value) => value.photo)),
        ));
      });
    });
  }

  Container userBottomSheet(UserModel user) {
    return Container(
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 5,
                padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.photo),
                ),
                title: Text(user.name),
                subtitle: Text(user.email),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Get.theme.primaryColor),
                      onPressed: () {},
                      icon: Icon(Icons.navigation),
                      label: Text("Wants to meet")),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Get.theme.primaryColor,
                          side: BorderSide(color: Get.theme.primaryColor)),
                      onPressed: () {
                        if (Get.isBottomSheetOpen) {
                          Get.back();
                        }
                        Get.toNamed('/conversationscreen',
                            arguments: {'id': user.id});
                      },
                      icon: Icon(Icons.chat_bubble),
                      label: Text("Wants to chat"))
                ],
              )
            ],
          ),
        ));
  }

  Future<UserModel> title(String uid) async {
    var title = await FirestoreDB()
        .getUserOnce(uid)
        .then((value) => UserModel().fromMap(value));
    return title;
  }

  paint() {
    RepaintBoundary(
      key: iconKey,
      child: IconButton(
          icon: Icon(Icons.star),
          onPressed: () {
            // Do something
          }),
    );
  }

  Future<BitmapDescriptor> getMarkerIcon(Size size, url) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Radius radius = Radius.circular(size.width / 2);

    final Paint tagPaint = Paint()..color = Colors.blue;
    final double tagWidth = 40.0;

    final Paint shadowPaint = Paint()..color = Colors.blue.withAlpha(100);
    final double shadowWidth = 5.0;

    final Paint borderPaint = Paint()..color = Colors.white;
    final double borderWidth = 3.0;

    final double imageOffset = shadowWidth + borderWidth;
    File markerImageFile = await DefaultCacheManager().getSingleFile(url);

    // Add shadow circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0.0, 0.0, size.width, size.height),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        shadowPaint);

    // Add border circle
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(shadowWidth, shadowWidth,
              size.width - (shadowWidth * 2), size.height - (shadowWidth * 2)),
          topLeft: radius,
          topRight: radius,
          bottomLeft: radius,
          bottomRight: radius,
        ),
        borderPaint);

    // Oval for the image
    Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
        size.width - (imageOffset * 2), size.height - (imageOffset * 2));

    // Add path for oval image
    canvas.clipPath(Path()..addOval(oval));

    // Add image
    ui.Image image = await getImageFromPath(markerImageFile
        .path); // Alternatively use your own method to get the image
    paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

    // Convert canvas to image
    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());

    // Convert image to bytes
    final ByteData byteData =
        await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData.buffer.asUint8List();
    showMap.value = true;
    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<ui.Image> getImageFromPath(String imagePath) async {
    File imageFile = File(imagePath);

    Uint8List imageBytes = imageFile.readAsBytesSync();

    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(imageBytes, (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }
}
