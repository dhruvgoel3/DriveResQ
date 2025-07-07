import 'package:driveresq/resources/app_resources/app_colors.dart';
import 'package:driveresq/resources/app_resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectUserContainer extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Color buttonColor;
  final Color titleColor;

  const SelectUserContainer({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height = 50,
    this.width = double.infinity,
    this.buttonColor = Colors.blue,
    this.titleColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.LightBlue,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Column(
              children: [
                Center(child: Text(title, style: AppTextStyles.ButtonTitle)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
