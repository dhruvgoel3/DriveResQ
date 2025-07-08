import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewmodel/authControllers/driver_signup_contoller.dart';

class DriverSignupScreenModule extends StatelessWidget {
  final controller = Get.put(DriverSignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Driver Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          children: [
            TextField(
              controller: controller.usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            controller.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: controller.signUpDriver,
              child: Text("Sign Up"),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/driver-login'),
              child: Text("Already have an account? Login"),
            ),
          ],
        )),
      ),
    );
  }
}