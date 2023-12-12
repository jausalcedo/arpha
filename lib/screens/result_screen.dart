import 'dart:io';

import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/screens/model_view_screens/cpu_model_screen.dart';
import 'package:arpha/screens/model_view_screens/fan_model_screen.dart';
import 'package:arpha/screens/model_view_screens/gpu_model_screen.dart';
import 'package:arpha/screens/model_view_screens/motherboard_model_screen.dart';
import 'package:arpha/screens/model_view_screens/psu_model_screen.dart';
import 'package:arpha/screens/model_view_screens/ram_model_screen.dart';
import 'package:arpha/screens/model_view_screens/storage_model_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen(this.image, {super.key});

  final XFile image;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  File? file;
  late List<dynamic>? _recognitions;
  String label = "";
  String labelTrimmed = "";
  String source = "";

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
      _recognitions = recognitions;
      label = _recognitions![0]['label'];
      labelTrimmed = label.substring(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.image.path);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "Result")
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.file(picture)
            ),
          ),
          Text("Component: $labelTrimmed", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("Confidence Level: ${n.format(_recognitions![0]['confidence'] * 100)}%"),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue[700])
            ),
            onPressed: (){
              if (double.parse(n.format(_recognitions![0]['confidence'] * 100)) >= 75) {
                if (labelTrimmed == 'cpu') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CpuModelScreen())
                  );
                } else if (labelTrimmed == 'fan') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FanModelScreen())
                  );
                } else if (_recognitions![0]['label'].substring(1) == 'gpu') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const GpuModelScreen())
                  );
                } else if (labelTrimmed == 'motherboard') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const MotherboardModelScreen())
                  );
                } else if (labelTrimmed == 'psu') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const PsuModelScreen())
                  );
                } else if (labelTrimmed == 'ram') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const RamModelScreen())
                  );
                } else if (labelTrimmed == 'storage') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const StorageModelScreen())
                  );
                }
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(double.parse(n.format(_recognitions![0]['confidence'] * 100)) >= 75 ? "View in AR" : "Try again", style: const TextStyle(color: Colors.white),)
          )
        ],
      )
    );
  }
}