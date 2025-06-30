import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.roleSelector); // Navigate after 3 sec
    });
  }
}
