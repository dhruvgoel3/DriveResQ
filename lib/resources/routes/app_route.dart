import 'package:driveresq/resources/routes/route_names.dart';
import 'package:driveresq/view/Driver/bottomnavbar/mechanic_bottomnavbar.dart';
import 'package:driveresq/view/Mechanic/bottomnavbar/mechanic_bottomnavbar.dart';
import 'package:driveresq/view/login/driverlogin/driver_loginscreen_module.dart';
import 'package:driveresq/view/selectRole/select_role_screen.dart';
import 'package:driveresq/view/signup/mechanicSignup/mechanic_signup_screen_module.dart';
import 'package:driveresq/view/splashscreen/splash_screen.dart';
import 'package:get/get.dart';
import '../../view/login/mechaniclogin/login_screen.dart';
import '../../view/signup/driversignup/driver_signup_screen_module.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: Duration(milliseconds: 250),
    ),
    GetPage(name: RouteName.selectRoleScreen, page: () => SelectRoleScreen()),

    // Mechanic DashBoard Routes
    GetPage(
      name: RouteName.mechanicSignUpScreen,
      page: () => MechanicSignupScreenModule(),
    ),
    GetPage(
      name: RouteName.mechanicLoginScreen,
      page: () => MechanicLoginScreen(),
    ),
    GetPage(
      name: RouteName.mechanicBottomNavbar,
      page: () => MechanicBottomnavbar(),
    ),

    //   Driver DashBoard Routes
    GetPage(
      name: RouteName.driverLoginScreen,
      page: () => DriverLoginScreenModule(),
    ),
    GetPage(
      name: RouteName.driverSignUpScreen,
      page: () => DriverSignupScreenModule(),
    ),
    GetPage(
      name: RouteName.driverBottomNavBar,
      page: () => DriverBottomNavBar(),
    ),
  ];
}
