import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MechanicLoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final userOrEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final supabase = Supabase.instance.client;

  String? validateUserOrEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email or Username is required';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Minimum 6 characters';
    return null;
  }

  Future<void> loginUser() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final input = userOrEmailController.text.trim();
    final password = passwordController.text.trim();

    try {
      String? emailToLogin;

      // Try to detect if input is an email
      if (GetUtils.isEmail(input)) {
        emailToLogin = input;
      } else {
        // User entered username → lookup email from `mechanics` table
        final response = await supabase
            .from('mechanics')
            .select('email')
            .eq('username', input)
            .maybeSingle();

        if (response != null) {
          emailToLogin = response['email'];
        } else {
          Get.snackbar("Error", "Username not found");
          isLoading.value = false;
          return;
        }
      }

      // Proceed with login
      await supabase.auth.signInWithPassword(
        email: emailToLogin,
        password: password,
      );

      Get.snackbar("Success", "Login successful!");
      // Navigate: Get.toNamed('/mechanicDashboard');
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
