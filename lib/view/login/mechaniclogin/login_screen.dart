import 'package:driveresq/resources/app_resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import '../../../controllers/authControllers/mechanic_login_controller.dart';
import '../../../resources/app_resources/text_styles.dart';
import '../../../widgets/components/custom_textformfields.dart';

class MechanicLoginScreen extends StatelessWidget {
  final controller = Get.put(MechanicLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LightCamel,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Form(
            key: controller.formKey,
            child: ListView(
              children: [
                SizedBox(height: 200),
                Padding(
                  padding: const EdgeInsets.only(left: 85),
                  child: Text("Login Here", style: AppTextStyles.headingLarge),
                ),
                SizedBox(height: 60),
                CustomTextFormField(
                  hint: "Username or Email",
                  controller: controller.userOrEmailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateUserOrEmail,
                  icon: LineIcon(Icons.perm_identity, color: Colors.black),
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  hint: "Password",
                  controller: controller.passwordController,
                  isObscure: true,
                  validator: controller.validatePassword,
                  icon: LineIcon(Icons.lock, color: Colors.black),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.DarkCamel,
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.loginUser,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Login", style: AppTextStyles.buttonText),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: AppTextStyles.normalText2,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => MechanicLoginScreen());
                        },
                        child: Text("SignUp", style: AppTextStyles.normalText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
