import 'package:driveresq/resources/routes/route_names.dart';
import 'package:driveresq/view/Mechanic/Chat/mechanic_chat_module.dart';
import 'package:driveresq/view/Mechanic/History/mechanic_history_screen_module.dart';
import 'package:driveresq/view/Mechanic/Home/mechanic_home_module.dart';
import 'package:driveresq/view/Mechanic/Profile/profile_module.dart';
import 'package:driveresq/view/Mechanic/bottomnavbar/mechanic_bottomnavbar.dart';
import 'package:driveresq/view/selectRole/select_role_screen.dart';
import 'package:driveresq/view/signup/mechanicSignup/mechanic_signup_screen_module.dart';
import 'package:driveresq/view/splashscreen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../view/login/mechaniclogin/login_screen.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 250),
    ),
    GetPage(name: RouteName.selectRoleScreen, page: () => SelectRoleScreen()),
    GetPage(
      name: RouteName.mechanicSignUpScreen,
      page: () => MechanicSignupScreenModule(),
    ),
    GetPage(
      name: RouteName.mechanicBottomnavbar,
      page: () => MechanicBottomnavbar(),
    ),
  ];
}
