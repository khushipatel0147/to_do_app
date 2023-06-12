import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:to_do_app/view/dataScreen.dart';
import 'package:to_do_app/view/homeScreen.dart';
import 'package:to_do_app/view/locationScreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (p0) => HomeScreen(),
      '/data': (p0) => DataScreen(),
      '/loc': (p0) => LocationScreen(),


    },
  ));
}
