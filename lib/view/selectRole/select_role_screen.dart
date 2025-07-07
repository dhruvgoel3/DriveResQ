import 'package:driveresq/resources/app_resources/app_colors.dart';
import 'package:driveresq/widgets/components/user_role_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  double screenWidth = Get.width;
  double screenHeight = Get.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SelectUserContainer(
              title: "Mechanic",
              onPressed: () {},
              height: screenHeight * 0.2,
            ),
            SizedBox(height: 10),
            SelectUserContainer(
              title: "Driver  ",
              onPressed: () {},
              height: screenHeight * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}
