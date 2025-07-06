import 'package:driveresq/resources/routes/route_names.dart';
import 'package:driveresq/view/loginscreen/login_screen.dart';
import 'package:driveresq/view/splashscreen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 250),
    ),
    GetPage(name: RouteName.loginScreen, page: () => LoginScreen()),
  ];
}
