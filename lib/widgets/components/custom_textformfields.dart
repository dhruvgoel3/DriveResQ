import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final Icon icon;
  final TextEditingController controller;
  final bool isObscure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    Key? key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.isObscure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
