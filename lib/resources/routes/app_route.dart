import 'package:driveresq/resources/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => Placeholder(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 250),
    ),
  ];
}
