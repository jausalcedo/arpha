import 'package:arpha/components/app_drawer.dart';
import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/screens/compatibility_screen.dart';
import 'package:arpha/screens/identify/camera_screen.dart';
import 'package:arpha/screens/learn_screen.dart';
import 'package:arpha/screens/quiz/quiz_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "ARPHA")
      ),
      drawer: const AppDrawer(),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:() => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraScreen(),
                      )
                    ),
                    child: Image.asset("assets/images/identify.png", width: 350)
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LearnScreen(),
                      )
                    ),
                    child: Image.asset("assets/images/study.png", width: 450)
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompatibilityScreen(),
                      )
                    ),
                    child: Image.asset("assets/images/check.png", width: 450)
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizHomeScreen(),
                      )
                    ),
                    child: Image.asset("assets/images/quiz.png", width: 450)
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}