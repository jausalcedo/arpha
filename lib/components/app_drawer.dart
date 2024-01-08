import 'package:arpha/screens/auth/auth_screen.dart';
import 'package:arpha/screens/build_history.dart';
import 'package:arpha/screens/compatibility_screen.dart';
import 'package:arpha/screens/identify/camera_screen.dart';
import 'package:arpha/screens/quiz/quiz_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:arpha/screens/home_screen.dart';
import 'package:arpha/screens/learn_screen.dart';
 
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => HomeScreen(),
              ),
            ),
            leading: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CameraScreen(),
              ),
            ),
            leading: const Icon(Icons.search_rounded),
            title: const Text('Identify'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const LearnScreen(),
              ),
            ),
            leading: const Icon(Icons.menu_book_rounded),
            title: const Text('Learn'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CompatibilityScreen(),
              ),
            ),
            leading: const Icon(Icons.checklist_rounded),
            title: const Text('Check Compatibility'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const BuildHistory(),
              ),
            ),
            leading: const Icon(Icons.access_time_rounded),
            title: const Text('PC Build History'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const QuizHomeScreen(),
              ),
            ),
            leading: const Icon(Icons.quiz_outlined),
            title: const Text('Quiz'),
          ),
          ListTile(
            onTap: () => FirebaseAuth.instance.signOut()
              .then((res) {
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (context) => const AuthScreen()),
                  (route) => false
                );
              }),
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}