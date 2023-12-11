// ignore_for_file: use_build_context_synchronously

import 'package:arpha/components/custom_text_button.dart';
import 'package:arpha/components/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.onTap
  });

  final Function()? onTap;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailInput = TextEditingController();

  final passwordInput = TextEditingController();

  void signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator()
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailInput.text,
        password: passwordInput.text
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorDialog(e.code);
    }
    Navigator.pop(context);
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Try again.")
          )
        ],
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(50),
                // ARPHA logo
                Image.asset("assets/images/arpha_logo_black.png"),
          
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //welcome text
                        const Center(
                          child: Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        const Gap(10),
                  
                        // email input field
                        const Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                        CustomTextField(controller: emailInput, obscureText: false),
                        const Gap(10),
                        
                        // password input field
                        const Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                        CustomTextField(controller: passwordInput, obscureText: true),
                        const Gap(10),
          
                        // Forgot password
                        const Text("Forgot password?"),
                        const Gap(20),
          
                        // Login button
                        CustomTextButton(
                          signInTapped: signIn,
                          text: "Login",
                        ),
                        const Gap(20),
          
                        // Not a member? Register Now
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Need an account? "),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                "Register here.",
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.bold
                                ),  
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}