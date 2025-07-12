import 'package:driveresq/resources/app_resources/app_colors.dart';
import 'package:driveresq/resources/app_resources/text_styles.dart';
import 'package:driveresq/view/login/mechaniclogin/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import '../../../viewmodel/authControllers/mechanic_signup_controller.dart';
import '../../../widgets/components/custom_textformfields.dart';

class MechanicSignupScreenModule extends StatelessWidget {
  final controller = Get.put(MechanicSignUpController());

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
                // Padding(
                //   padding:  EdgeInsets.only(right: 100),
                //   child: Image.asset("assets/worker with boxes.png",height: 270),
                // ),
                SizedBox(height: 140),

                Padding(
                  padding: const EdgeInsets.only(left: 85),
                  child: Text("SignUp Here", style: AppTextStyles.headingLarge),
                ),
                SizedBox(height: 60),

                CustomTextFormField(
                  hint: "Mechanic Name",
                  controller: controller.usernameController,
                  validator: controller.validateUsername,
                  icon: LineIcon(Icons.perm_identity, color: Colors.black),
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  hint: "Email",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateEmail,
                  icon: LineIcon(Icons.mail_outline, color: Colors.black),
                ),
                SizedBox(height: 12),
                CustomTextFormField(
                  hint: "Password",
                  controller: controller.passwordController,
                  isObscure: true,
                  validator: controller.validatePassword,
                  icon: LineIcon(Icons.lock_rounded, color: Colors.black),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.DarkCamel,
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.signUpWithEmail,

                  child: controller.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Sign Up", style: AppTextStyles.buttonText),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Row(
                    children: [
                      Text(
                        "Already have an account ?",
                        style: AppTextStyles.normalText2,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => MechanicLoginScreen());
                        },
                        child: Text("Login", style: AppTextStyles.normalText),
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
