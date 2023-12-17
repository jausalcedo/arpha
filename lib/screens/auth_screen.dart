import 'package:arpha/screens/home_screen.dart';
import 'package:arpha/screens/login_or_register_screen.dart';
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
            return HomeScreen();
          } else {
            return const LoginOrRegisterScreen();
          }
        }),
      )
    );
  }
}