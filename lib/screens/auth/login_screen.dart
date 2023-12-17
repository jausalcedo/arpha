// ignore_for_file: use_build_context_synchronously

import 'package:arpha/components/custom_text_button.dart';
import 'package:arpha/components/custom_text_field.dart';
import 'package:arpha/helpers/utils.dart';
import 'package:arpha/main.dart';
import 'package:arpha/screens/auth/forgot_password_screen.dart';
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

  bool obscurePassword = true;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
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
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst); 
  }

  @override
  void dispose() {
    emailInput.dispose();
    passwordInput.dispose();

    super.dispose();
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
                        CustomTextField(
                          controller: passwordInput,
                          obscureText: obscurePassword,
                          suffixIcon: IconButton(
                            onPressed: togglePasswordVisibility,
                            icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off)
                          )
                        ),
                        const Gap(10),
          
                        // forgot password
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const ForgotPasswordScreen())
                          ),
                          child: const Text("Forgot password?")
                        ),
                        const Gap(20),
          
                        // login button
                        CustomTextButton(
                          signInTapped: signIn,
                          text: "Login",
                        ),
                        const Gap(20),
          
                        // need an account? register here
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