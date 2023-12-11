// ignore_for_file: use_build_context_synchronously

import 'package:arpha/components/custom_text_button.dart';
import 'package:arpha/components/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
    required this.onTap
  });

  final Function()? onTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstNameInput = TextEditingController();
  final lastNameInput = TextEditingController();
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
  final confirmPasswordInput = TextEditingController();

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator()
      ),
    );

    try {
      if (passwordInput.text == confirmPasswordInput.text) {
        // create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailInput.text,
          password: passwordInput.text
        );
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Registered Successfully"),
            actions: [
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: const Text("Back to Login"))
            ],
        ));
      } else {
        Navigator.pop(context);
        showErrorDialog("Passwords do not match.");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorDialog(e.code);
    }
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
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(25),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //welcome text
                        const Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        const Gap(10),

                        //first name input field
                        const Text(
                          "First Name",
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                        CustomTextField(controller: firstNameInput, obscureText: false),
                        const Gap(10),

                        // last name input field
                        const Text(
                          "Last Name",
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                        CustomTextField(controller: lastNameInput, obscureText: false),
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

                        // confirm password input field
                        const Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                        CustomTextField(controller: confirmPasswordInput, obscureText: true),
                        const Gap(20),
          
                        // login button
                        CustomTextButton(
                          signInTapped: signUp,
                          text: "Register",
                        ),
                        const Gap(20),
          
                        // already have an account? login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? "),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Text(
                                "Login here.",
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