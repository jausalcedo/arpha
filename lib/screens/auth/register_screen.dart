// ignore_for_file: use_build_context_synchronously

import 'package:arpha/components/custom_text_button.dart';
import 'package:arpha/components/custom_text_field.dart';
import 'package:arpha/helpers/utils.dart';
import 'package:arpha/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
    required this.onTap
  }) : super(key: key);

  final Function()? onTap;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameInput = TextEditingController();
  final lastNameInput = TextEditingController();
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
  final confirmPasswordInput = TextEditingController();

  @override
  void dispose() {
    firstNameInput.dispose();
    lastNameInput.dispose();
    emailInput.dispose();
    passwordInput.dispose();
    confirmPasswordInput.dispose();

    super.dispose();
  }

  void signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

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
        showErrorDialog("Passwords do not match.");
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
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

  bool obscurePassword = true;
  bool obscureCPassword = true;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  void toggleCPasswordVisibility() {
    setState(() {
      obscureCPassword = !obscureCPassword;
    });
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
                    child: Form(
                      key: formKey,
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
                          CustomTextField(
                            controller: emailInput,
                            obscureText: false,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,
                          ),
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
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                              value != null && value.length < 6
                                ? 'Enter min. 6 characters'
                                : null,
                          ),
                          const Gap(10),
                    
                          // confirm password input field
                          const Text(
                            "Confirm Password",
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          CustomTextField(
                            controller: confirmPasswordInput,
                            obscureText: obscureCPassword,
                            suffixIcon: IconButton(
                              onPressed: toggleCPasswordVisibility,
                              icon: Icon(obscureCPassword ? Icons.visibility : Icons.visibility_off)
                            )
                          ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}