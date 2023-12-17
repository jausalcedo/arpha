import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/components/custom_text_button.dart';
import 'package:arpha/components/custom_text_field.dart';
import 'package:arpha/helpers/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailInput = TextEditingController();

  @override
  void dispose() {
    emailInput.dispose();
    
    super.dispose();
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailInput.text);

      Utils.showSnackBar("Password Reset Email Sent!");
      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          title: "Reset Password"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Receive an email to reset your password."),
            const Gap(20),
            const Text(
              "Enter your email",
              style: TextStyle(
                fontSize: 16
              ),
            ),
            const Gap(20),
            CustomTextField(
              controller: emailInput,
              obscureText: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                email != null && !EmailValidator.validate(email)
                  ? 'Enter a valid email'
                  : null,
            ),
            const Gap(20),
            CustomTextButton(
              signInTapped: resetPassword,
              text: "Send Reset Password Email Link"
            )
          ],
        ),
      ),
    );
  }
}