import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/components/for_quiz/quiz_grid_tile.dart';
import 'package:arpha/screens/quiz/quiz_all.dart';
import 'package:arpha/screens/quiz/quiz_cpu.dart';
import 'package:arpha/screens/quiz/quiz_fan.dart';
import 'package:arpha/screens/quiz/quiz_gpu.dart';
import 'package:arpha/screens/quiz/quiz_motherboard.dart';
import 'package:arpha/screens/quiz/quiz_psu.dart';
import 'package:arpha/screens/quiz/quiz_ram.dart';
import 'package:arpha/screens/quiz/quiz_storage.dart';
import 'package:flutter/material.dart';

class QuizHomeScreen extends StatelessWidget {
  const QuizHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "Select Quiz Type")
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: const [
            QuizGridTile(
              source: "assets/images/quiz/ALL.png",
              screen: QuizAllScreen(),
            ),
            QuizGridTile(
              source: "assets/images/quiz/MOTHERBOARD.png",
              screen: QuizMotherboardScreen(),
            ),
            QuizGridTile(
              source: "assets/images/quiz/CPU.png",
              screen: QuizCPUScreen(),
            ),
            QuizGridTile(
              source: "assets/images/quiz/RAM.png",
              screen: QuizRAMScreen(),
            ),
            QuizGridTile(
              source: "assets/images/quiz/PSU.png",
              screen: QuizPSUScreen(),
            ),
            QuizGridTile(
              source: "assets/images/quiz/STORAGE.png",
              screen: QuizStorageScreen(),
            ),
            QuizGridTile(
              source: "assets/images/quiz/FAN.png",
              screen: QuizFanScreen(),
            ),
            QuizGridTile(
              source: "assets/images/quiz/GPU.png",
              screen: QuizGPUScreen(),
            ),
          ],
        ),
      ),
    );
  }
}