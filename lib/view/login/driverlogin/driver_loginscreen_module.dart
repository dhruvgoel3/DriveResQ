import 'package:driveresq/widgets/components/custom_textformfields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import '../../../controllers/authControllers/driver_login_controller.dart';
import '../../../resources/routes/route_names.dart';

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
                icon: LineIcon(Icons.email_outlined,color: Colors.black,),
              ),
              CustomTextFormField(
                hint: "Email",
                controller: controller.passwordController,
                icon: LineIcon(Icons.lock,color: Colors.black,),
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
