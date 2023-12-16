import 'package:flutter/material.dart';

class CustomGridTile extends StatelessWidget {
  const CustomGridTile({
    super.key,
    required this.source,
    required this.screen,
    required this.text
  });

  final String source;
  final Widget screen;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => screen)
      ),
      child: GridTile(
        child: Image.asset(source),
      ),
    );
  }
}