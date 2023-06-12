import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:to_do_app/contoller/location_controller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocationController controller = Get.put(LocationController());
  LocationPermission? permission;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade500,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Location",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: Colors.blueGrey.shade50),
        ),
        leading: BackButton(
            onPressed: () {
              Get.back();
            },
            color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.location,
                    Permission.storage,
                    Permission.camera
                  ].request();
                },
                child: Text(
                  "Permission",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade500)),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  permission = await Geolocator.checkPermission();
                  if (permission == LocationPermission.denied) {
                    await Geolocator.requestPermission();
                  } else {
                    Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    controller.lat.value = position.latitude;
                    controller.log.value = position.longitude;
                  }
                },
                child: Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade500)),
            SizedBox(height: 10),
            Obx(() => Text("${controller.lat} --  ${controller.log}")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  List<Placemark> placeList = await placemarkFromCoordinates(
                      controller.lat.value, controller.log.value);
                  controller.currentLoc.value = placeList[1];
                },
                child: Text(
                  "Address",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade500)),
            SizedBox(height: 10),
            Obx(() => Text("${controller.currentLoc}")),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  openAppSettings();
                },
                child: Text(
                  "Open Setting",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade500)),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  Get.toNamed('/map');
                },
                child: Text(
                  "Open Map",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade500)),
          ],
        ),
      ),
    ));
  }
}
