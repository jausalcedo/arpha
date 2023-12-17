import 'package:arpha/constants/quiz_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLength,
    required this.elapsedTime,
    required this.isTimeUp,
    required this.onPressed,
  }) : super(key: key);

  final int result;
  final int questionLength;
  final int elapsedTime;
  final bool isTimeUp;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(color: neutral, fontSize: 22.0),
            ),
            const SizedBox(height: 20.0),
            CircleAvatar(
              radius: 70.0,
              backgroundColor: result == 7
                  ? Colors.yellow
                  : result < 7
                      ? incorrect
                      : correct,
              child: Text(
                '$result/$questionLength',
                style: const TextStyle(fontSize: 30.0),
              ),
            ),
            const Gap(20),
            Text(
              result == 7
                  ? 'Almost There'
                  : result < 7
                      ? 'Try Again ?'
                      : 'Great!',
              style: const TextStyle(color: neutral),
            ),
            if (isTimeUp)
              const Gap(20),
              Text(
                'Time Taken: ${elapsedTime}s',
                style: const TextStyle(color: neutral),
              ),
            const Gap(25),
            GestureDetector(
              onTap: onPressed,
              child: const Text(
                'Start Over',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
