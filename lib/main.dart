import 'package:driveresq/resources/routes/app_route.dart';
import 'package:driveresq/resources/routes/route_names.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://hduylrxdjcdcsoiwkhfz.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhkdXlscnhkamNkY3NvaXdraGZ6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAyMzM0NDAsImV4cCI6MjA2NTgwOTQ0MH0.GbRQib4HZU2TaivbBk--ZfV5HSutOwQQjdraJYSomxY',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouteName.driverSignUpScreen,
      getPages: AppRoutes.appRoutes(),
      title: 'DriverResQ',
      debugShowCheckedModeBanner: false,
    );
  }
}
