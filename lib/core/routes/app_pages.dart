import 'package:get/get.dart';
import '../../features/Splash/presentation/bindings/splash_binding.dart';
import '../../features/Splash/presentation/pages/splash_page.dart';

class AppPages {
  static final pages = [
    GetPage(name: '/', page: () => SplashScreen(), binding: SplashBinding()),
  ];
}
