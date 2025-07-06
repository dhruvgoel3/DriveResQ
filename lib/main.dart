import 'package:driveresq/resources/routes/app_route.dart';
import 'package:driveresq/resources/routes/route_names.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouteName.splashScreen,
      getPages: AppRoutes.appRoutes(),
      title: 'DriverResQ',
      debugShowCheckedModeBanner: false,

    );
  }
}
