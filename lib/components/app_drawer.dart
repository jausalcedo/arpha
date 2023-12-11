import 'package:arpha/screens/compatibility_checker_screen.dart';
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
                builder: (_) => const LearnScreen(),
              ),
            ),
            leading: const Icon(Icons.menu_book_rounded),
            title: const Text('Learn'),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CompatibilityCheckerScreen(),
              ),
            ),
            leading: const Icon(Icons.checklist_rounded),
            title: const Text('Check Compatibility'),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
          ),
        ],
      ),
    );
  }
}