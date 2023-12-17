import 'package:arpha/screens/auth/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    required this.title
  });

  final String title;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: (){
            FirebaseAuth.instance.signOut()
            .then((res) {
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false
              );
            });
          },
          icon: const Icon(Icons.logout)
        ),
      ],
    );
  }
}