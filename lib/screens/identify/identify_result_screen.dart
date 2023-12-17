import 'dart:io';

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
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tflite_v2/tflite_v2.dart';

class IdentifyResultScreen extends StatefulWidget {
  const IdentifyResultScreen(this.image, {super.key});

  final XFile image;

  @override
  State<IdentifyResultScreen> createState() => _IdentifyResultScreenState();
}

class _IdentifyResultScreenState extends State<IdentifyResultScreen> {
  File? file;
  var label = "";
  var confidence = 0.0;
  String labelTrimmed = "";
  String source = "";
  Widget? screen;

  NumberFormat n = NumberFormat.decimalPatternDigits(decimalDigits: 2);

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
    detectImage(File(widget.image.path));
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/object_detection/model.tflite",
      labels: "assets/object_detection/labels.txt"
    );
  }

  Future detectImage(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 7,
      threshold: 0.1,
      imageMean: 127.5,
      imageStd: 127.5
    );
    setState(() {
      label = (recognitions![0]['label'].substring(2));
      confidence = recognitions[0]['confidence'] * 100.0;
      print("$label at $confidence% confidence");
    });
  }

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.image.path);

    if (label == "motherboard") {
      screen = const QuizMotherboardScreen();
    } else if (label == "cpu") {
      screen = const QuizCPUScreen();
    } else if (label == "ram") {
      screen = const QuizRAMScreen();
    } else if (label == "psu") {
      screen = const QuizPSUScreen();
    } else if (label == "storage") {
      screen = const QuizStorageScreen();
    } else if (label == "fan") {
      screen = const QuizFanScreen();
    } else if (label == "gpu") {
      screen = const QuizGPUScreen();
    }

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "Result")
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.file(
                picture,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            ),
          ),
          confidence < 90.0 ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Low confidence. Please try again."),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Try Again")
              )
            ],
          ) : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                  "Component: ${label.toUpperCase()}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Confidence: ${confidence.toStringAsFixed(2)}%",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)
                  ),
                  onPressed: (){},
                  child: const Text("View in AR")
                ),
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
                        source: "assets/images/quiz/${label.toUpperCase()}.png",
                        screen: screen,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}