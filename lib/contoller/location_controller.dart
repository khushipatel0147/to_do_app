import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationController extends GetxController
{
    RxDouble lat =0.0.obs;
    RxDouble log =0.0.obs;

    Rx<Placemark> currentLoc =Placemark().obs;
}