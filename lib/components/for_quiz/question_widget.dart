import 'package:arpha/constants/quiz_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.question,
    required this.indexAction,
    required this.totalQuestions
  }) : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Question ${indexAction + 1}/$totalQuestions',
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.blue,
            ),
          ),
          const Gap(10),
          Text(
            question,
            style: const TextStyle(
              fontSize: 24.0,
              color: neutral,
            ),
          ),
        ],
      ),
    );
  }
}
