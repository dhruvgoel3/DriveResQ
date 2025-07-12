import "package:driveresq/resources/app_resources/app_colors.dart";
import "package:driveresq/resources/app_resources/text_styles.dart";
import "package:driveresq/widgets/components/round_button.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get/get_core/src/get_main.dart";
import "package:line_icons/line_icon.dart";

import "../../viewmodel/role_selection_viewmodel.dart";

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;
    final controller = Get.put(RoleSelectionViewModel());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.088),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              "assets/DriveResQ_Simple_Logo_with_Location_Pin-removebg-preview.png",
              height: screenHeight * 0.6,
            ),
          ),
          SizedBox(height: screenHeight * 0.0),
          Stack(
            children: [
              Container(
                height: screenHeight * 0.31,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.LightCamel,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, -4), // shadow ABOVE the container
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 20),
                    Text(
                      "Finding a mechanic ?",
                      style: AppTextStyles.selectRoleText1,
                    ),
                    SizedBox(height: 6),

                    Text(
                      "Or want's to help drivers near you ?",
                      style: AppTextStyles.selectRole2,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.13,
                      left: screenWidth * 0.06,
                    ),
                    child: RoundButton(
                      title: "I'm Driver",
                      onPressed: () {
                        controller.navigateToDriverSignup();
                      },
                      height: screenHeight * 0.065,
                      width: screenWidth * 0.6,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.06),
                    child: RoundButton(
                      title: "I'm Mechanic",
                      onPressed: () {
                        controller.navigateToMechanicSignup();
                      },
                      height: screenHeight * 0.065,
                      width: screenWidth * 0.87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
