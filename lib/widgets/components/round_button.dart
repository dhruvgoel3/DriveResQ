import 'dart:ffi';

import 'package:flutter/material.dart';

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
  }) : super(key: key)

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container());
  }
}
