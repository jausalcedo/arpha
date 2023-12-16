import 'package:flutter/material.dart';

class QuizGridTile extends StatelessWidget {
  const QuizGridTile({
    super.key,
    required this.source,
  });

  final String source;
  // ipasa mo yung name ng component din
  // para madetermine yung screen na ia-output

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.of(context).push(
      //   MaterialPageRoute(builder: (context) => screen)
      // ),
      child: GridTile(
        child: Image.asset(source),
      ),
    );
  }
}