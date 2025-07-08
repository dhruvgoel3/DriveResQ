import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DriverLoginController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}\$');
  final passwordRegex = RegExp(r'^.{6,}\$');

  Future<void> loginDriver() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (!emailRegex.hasMatch(email) || !passwordRegex.hasMatch(password)) {
      Get.snackbar("Error", "Invalid email or password format");
      return;
    }

    isLoading.value = true;
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      Get.snackbar("Success", "Logged in successfully");
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}