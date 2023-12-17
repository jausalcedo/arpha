import 'package:arpha/components/for_quiz/quiz_grid_tile.dart';
import 'package:arpha/models/component_learn_model.dart';
import 'package:arpha/screens/quiz/quiz_cpu.dart';
import 'package:arpha/screens/quiz/quiz_fan.dart';
import 'package:arpha/screens/quiz/quiz_gpu.dart';
import 'package:arpha/screens/quiz/quiz_motherboard.dart';
import 'package:arpha/screens/quiz/quiz_psu.dart';
import 'package:arpha/screens/quiz/quiz_ram.dart';
import 'package:arpha/screens/quiz/quiz_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../screens/quiz/quiz_all.dart';

// ignore: must_be_immutable
class ComponentCard extends StatelessWidget {
  ComponentCard({
    super.key,
    required this.componentLearn,
    this.screen,
    this.label
  });

  final ComponentLearn componentLearn;
  Widget? screen;
  String? label;

  @override
  Widget build(BuildContext context) {
    switch (componentLearn.title) {
      case "Motherboard":
        screen = const QuizMotherboardScreen();
        label = "MOTHERBOARD";
        break;
      case "Central Processing Unit (CPU)":
        screen = const QuizCPUScreen();
        label = "CPU";
        break;
      case "Random Access Memory (RAM)":
        screen = const QuizRAMScreen();
        label = "RAM";
        break;
      case "Storage":
        screen = const QuizStorageScreen();
        label = "STORAGE";
        break;
      case "Power Supply Unit (PSU)":
        screen = const QuizPSUScreen();
        label = "PSU";
        break;
      case "Graphics Processing Unit (GPU)":
        screen = const QuizGPUScreen();
        label = "GPU";
        break;
      case "Fan":
        screen = const QuizFanScreen();
        label = "FAN";
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => showInfo(context),
        child: GridTile(
          footer: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)
            ),
            child: GridTileBar(
              backgroundColor: const Color.fromARGB(128, 0, 0, 0),
              title: Text(componentLearn.title),
            ),
          ),
          child: Image.asset(
            componentLearn.imagePath,
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }

  Future<dynamic> showInfo(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/learn/bg2.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back)
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      image: AssetImage(componentLearn.imagePath),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Gap(10),
                Center(
                  child: Text(
                    componentLearn.title,
                    style: const TextStyle(
                      fontSize: 24
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        CardLearnInfo(
                          title: "Description",
                          content: componentLearn.description,
                          color: componentLearn.color
                        ),
                        const Gap(10),
                        CardLearnInfo(
                          title: "Operation",
                          content: componentLearn.operation,
                          color: componentLearn.color
                        ),
                        const Gap(10),
                        CardLearnInfo(
                          title: "Components",
                          content: componentLearn.components,
                          color: componentLearn.color
                        ),
                        const Gap(10),
                        CardLearnInfo(
                          title: "History",
                          content: componentLearn.history,
                          color: componentLearn.color
                        ),
                        const Gap(10),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).width / 2,
                          child: GridView(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5
                            ),
                            children: [
                              const QuizGridTile(
                                source: "assets/images/quiz/ALL.png",
                                screen: QuizAllScreen(),
                              ),
                              QuizGridTile(
                                source: "assets/images/quiz/$label.png",
                                screen: screen,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

class CardLearnInfo extends StatelessWidget {
  const CardLearnInfo({
    super.key,
    required this.title,
    required this.content,
    required this.color,
  });

  final String title;
  final String content;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        side: BorderSide(
          color: color,
          width: 3,
          strokeAlign: 1
        )
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              )
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 18
              )
            ),
          ],
        ),
      ),
    );
  }
}