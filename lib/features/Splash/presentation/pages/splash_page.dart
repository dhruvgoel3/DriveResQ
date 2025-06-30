import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../conrollers/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/car mechanic.png",height: 200, // Add logo in pubspec.yaml
          width: 400,
        ),
      ),
    );
  }
}
