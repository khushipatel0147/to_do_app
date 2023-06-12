import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  RxDouble lat = 0.0.obs;
  RxDouble log = 0.0.obs;

  Rx<Placemark> currentLoc = Placemark().obs;

  RxSet<Marker> markers() {
    return {
      Marker(
        markerId: MarkerId("Current position"),
        position: LatLng(lat.value, log.value),
        // rotation: 90,
        // infoWindow: InfoWindow(title: "Current position"),
      )
    }.obs;
  }
}
