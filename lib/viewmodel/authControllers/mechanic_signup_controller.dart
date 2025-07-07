import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MechanicSignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final mechanicType = RxnString();
  final location = RxString("Fetching...");
  final isLoading = false.obs;

  final supabase = Supabase.instance.client;
  final mechanicTypes = ['Car', 'Bike', 'Truck'];

  @override
  void onInit() {
    super.onInit();
    _getLocation();
  }

  void setMechanicType(String? value) => mechanicType.value = value;

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      location.value = 'Location services are disabled';
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        location.value = 'Location permissions are denied';
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      location.value = 'Location permission permanently denied';
      return;
    }

    // If permission granted
    try {
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      location.value = '${pos.latitude}, ${pos.longitude}';
    } catch (e) {
      location.value = 'Location Error: ${e.toString()}';
    }
  }

  Future<void> signUpWithEmail() async {
    if (!formKey.currentState!.validate()) return;
    if (mechanicType.value == null) {
      Get.snackbar("Error", "Please select mechanic type");
      return;
    }

    isLoading.value = true;

    try {
      final authResponse = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final userId = authResponse.user?.id;
      if (userId != null) {
        await supabase.from('mechanics').insert({
          'id': userId,
          'username': usernameController.text.trim(),
          'email': emailController.text.trim(),
          'type': mechanicType.value,
          'location': location.value,
        });
      }

      Get.snackbar("Success", "Account created. Verify your email.");
      // Navigate to dashboard if needed
    } catch (e) {
      Get.snackbar("Signup Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final pattern = r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Name is required';
    if (value.length < 3) return 'Name must be at least 3 characters';
    return null;
  }
}
