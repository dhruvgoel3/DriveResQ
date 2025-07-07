import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../viewmodel/authControllers/mechanic_login_controller.dart';
import '../../../widgets/components/mechanic_textformfields.dart';

class MechanicLoginScreen extends StatelessWidget {
  final controller = Get.put(MechanicLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mechanic Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Form(
            key: controller.formKey,
            child: ListView(
              children: [
                CustomTextFormField(
                  hint: "Username or Email",
                  controller: controller.userOrEmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateUserOrEmail,
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  hint: "Password",
                  controller: controller.passwordController,
                  isObscure: true,
                  validator: controller.validatePassword,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.loginUser,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
