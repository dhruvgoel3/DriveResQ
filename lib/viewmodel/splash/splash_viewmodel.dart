import 'package:driveresq/resources/routes/route_names.dart';
import 'package:get/get.dart';

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(RouteName.selectRoleScreen);
  }
}
