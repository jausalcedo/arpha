import 'package:flutter/material.dart';

class QuizGridTile extends StatelessWidget {
  const QuizGridTile({
    super.key,
    required this.source,
    this.screen
  });

  final String source;
  final Widget? screen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => screen!)
      ),
      child: GridTile(
        child: Image.asset(source),
      ),
    );
  }
}