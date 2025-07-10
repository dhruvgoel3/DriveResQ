import 'dart:ffi';

import 'package:driveresq/resources/app_resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double height, width;
  final Color ButtonColor, TitleColor;

  RoundButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.height = 60,
    this.width = 50,
    this.ButtonColor = Colors.black,
    this.TitleColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.DarkCamel,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
