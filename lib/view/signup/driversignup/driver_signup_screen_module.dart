import 'package:driveresq/resources/routes/route_names.dart';
import 'package:driveresq/view/Driver/Home/driver_homesreen_module.dart';
import 'package:driveresq/widgets/components/custom_textformfields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import '../../../controllers/authControllers/driver_signup_contoller.dart';

class DriverSignupScreenModule extends StatelessWidget {
  final controller = Get.put(DriverSignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Driver Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            children: [
              CustomTextFormField(
                hint: "Username",
                controller: controller.usernameController,
                icon: LineIcon(Icons.perm_identity, color: Colors.black),
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                hint: "Email",
                controller: controller.emailController,
                icon: LineIcon(Icons.email_outlined, color: Colors.black),
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                hint: "Password",
                controller: controller.passwordController,
                icon: LineIcon(Icons.lock, color: Colors.black),
              ),
              SizedBox(height: 15),
              SizedBox(height: 20),
              controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.signUpDriver,
                      child: Text("Sign Up"),
                    ),
              TextButton(
                onPressed: () {
                  Get.to(() => DriverDashboardScreen());
                },
                // onPressed: () => Get.toNamed(RouteName.driverLoginScreen),
                child: Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
