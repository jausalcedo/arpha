import 'package:arpha/screens/auth/login_or_register_screen.dart';
import 'package:arpha/screens/auth/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          } else if (snapshot.hasData) {
            return const VerifyEmailScreen();
          } else {
            return const LoginOrRegisterScreen();
          }
        }),
      )
    );
  }
}