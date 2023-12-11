import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.obscureText,
  });

  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        fillColor: Colors.white,
        filled: true
      ),
      controller: controller,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
    );
  }
}