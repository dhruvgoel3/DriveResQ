import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DriverSignUpController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final isLoading = false.obs;

  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}\$');
  final passwordRegex = RegExp(r'^.{6,}\$');
  final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,16}\$');

  Future<void> signUpDriver() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final username = usernameController.text.trim();

    if (!emailRegex.hasMatch(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address");
      return;
    }
    if (!passwordRegex.hasMatch(password)) {
      Get.snackbar("Invalid Password", "Password must be at least 6 characters");
      return;
    }
    if (!usernameRegex.hasMatch(username)) {
      Get.snackbar("Invalid Username", "Username must be 3-16 characters, alphanumeric or underscore");
      return;
    }

    isLoading.value = true;
    try {
      final authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final userId = authResponse.user?.id;
      if (userId != null) {
        await supabase.from('drivers').insert({
          'id': userId,
          'username': username,
          'email': email,
        });
      }

      Get.snackbar("Success", "Signup successful. Check your email.");
    } catch (e) {
      Get.snackbar("Signup Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}