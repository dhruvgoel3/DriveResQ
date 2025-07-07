import 'package:driveresq/resources/routes/app_route.dart';
import 'package:driveresq/resources/routes/route_names.dart';
import 'package:driveresq/view/login/mechaniclogin/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../viewmodel/authControllers/mechanic_signup_controller.dart';
import '../../../widgets/components/mechanic_textformfields.dart';

class MechanicSignupScreenModule extends StatelessWidget {
  final controller = Get.put(MechanicSignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Form(
            key: controller.formKey,
            child: ListView(
              children: [
                SizedBox(height: 100),
                CustomTextFormField(
                  hint: "Mechanic Name",
                  controller: controller.usernameController,
                  validator: controller.validateUsername,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  hint: "Email",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateEmail,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  hint: "Password",
                  controller: controller.passwordController,
                  isObscure: true,
                  validator: controller.validatePassword,
                ),
                SizedBox(height: 12),
                Text("Your Location: ${controller.location.value.toString()}"),
                SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: controller.mechanicType.value,
                  items: controller.mechanicTypes
                      .map(
                        (type) =>
                            DropdownMenuItem(value: type, child: Text(type)),
                      )
                      .toList(),
                  onChanged: controller.setMechanicType,
                  decoration: InputDecoration(
                    hintText: "Select Mechanic Type",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (val) =>
                      val == null ? "Please select mechanic type" : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.signUpWithEmail,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Sign Up"),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text("Already have an account ?"),
                    TextButton(
                      onPressed: () {
                        Get.to(() => MechanicLoginScreen());
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
