import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewmodel/authControllers/driver_login_controller.dart';

class DriverLoginScreenModule extends StatelessWidget {
  final controller = Get.put(DriverLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Driver Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            children: [
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
                      onPressed: controller.loginDriver,
                      child: Text("Login"),
                    ),
              TextButton(
                onPressed: () => Get.toNamed('/driver-signup'),
                child: Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
