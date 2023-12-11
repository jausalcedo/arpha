import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.signInTapped,
    required this.text
  });

  final Function()? signInTapped;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: const ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size.fromHeight(50)),
          backgroundColor: MaterialStatePropertyAll(Colors.black)
        ),
        onPressed: signInTapped,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}