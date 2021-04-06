import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:nearmate/controller/mapcontroller.dart';
import 'package:nearmate/service/realtime.dart';

class MapScreen extends GetView<MapController> {
  //var controller = Get.find<MapController());
  var location = Location.instance.getLocation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // RepaintBoundary(
          //   key: controller.iconKey,
          //   child: IconButton(
          //       icon: Icon(Icons.star),
          //       onPressed: () {
          //         // Do something
          //       }),
          // ),
          Container(
            child: FutureBuilder<DataSnapshot>(
                future: RealtimeDB()
                    .getUserLocation(FirebaseAuth.instance.currentUser.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GetX<MapController>(
                      init: Get.put(MapController()),
                      builder: (controller) => controller.showMap.value == false
                          ? SizedBox()
                          : GoogleMap(
                              markers: controller.markers.value,
                              zoomControlsEnabled: false,
                              onMapCreated: (googleMapController) async {
                                googleMapController.setMapStyle(
                                    await getJsonFile().then((value) => value));
                                controller.mapController.value =
                                    googleMapController;
                                Timer(Duration(milliseconds: 1000), () {
                                  controller.ismapLoading.value = false;
                                });
                              },
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(snapshot.data.value['lat'],
                                      snapshot.data.value['lang']),
                                  zoom: 15),
                            ),
                    );
                  } else
                    return CircularProgressIndicator();
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 40),
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.2),
              child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.location_searching),
                  onPressed: () async {
                    controller.mapController.value.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(controller.latitude.value,
                                controller.longnitude.value),
                            zoom: 15)));
                  }),
            ),
          ),
          GetX<MapController>(
              init: Get.put(MapController()),
              builder: (controller) => controller.ismapLoading.value
                  ? Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      height: Get.mediaQuery.size.height,
                      width: Get.mediaQuery.size.width,
                      child: CircularProgressIndicator())
                  : SizedBox())
        ],
      ),
    );
  }

  Future<String> getJsonFile() async {
    return await rootBundle.loadString("assets/mapstyle.json");
  }
}
