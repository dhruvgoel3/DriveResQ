import 'package:driveresq/resources/routes/route_names.dart';
import 'package:driveresq/view/selectRole/select_role_screen.dart';
import 'package:driveresq/view/splashscreen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../view/login/login_screen.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 250),
    ),
    GetPage(name: RouteName.selectRoleScreen, page: () => SelectRoleScreen()),
  ];
}
