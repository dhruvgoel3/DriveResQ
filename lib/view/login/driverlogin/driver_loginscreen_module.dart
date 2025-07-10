import 'package:driveresq/widgets/components/mechanic_textformfields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/routes/route_names.dart';
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
              CustomTextFormField(
                hint: "Email",
                controller: controller.emailController,
              ),
              CustomTextFormField(
                hint: "Email",
                controller: controller.passwordController,
              ),
              SizedBox(height: 20),
              controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.loginDriver,
                      child: Text("Login"),
                    ),
              TextButton(
                onPressed: () {
                  Get.toNamed(RouteName.driverSignUpScreen);
                },

                child: Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
