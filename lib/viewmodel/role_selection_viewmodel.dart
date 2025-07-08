import 'package:driveresq/resources/routes/route_names.dart';
import 'package:get/get.dart';

class RoleSelectionViewModel extends GetxController {
  void navigateToMechanicSignup() {
    Get.toNamed(RouteName.mechanicSignUpScreen);
  }

  void navigateToDriverSignup() {
    Get.toNamed(RouteName.driverSignUpScreen);
  }
}
