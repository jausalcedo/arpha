import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    this.suffixIcon
  });

  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: suffixIcon
      ),
      controller: controller,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
    );
  }
}