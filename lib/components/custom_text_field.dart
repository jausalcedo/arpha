import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    this.suffixIcon,
    this.autovalidateMode,
    this.validator
  });

  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: suffixIcon
      ),
      controller: controller,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      autovalidateMode: autovalidateMode,
      validator: validator
    );
  }
}