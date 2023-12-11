import 'dart:typed_data';

import 'package:arpha/components/app_drawer.dart';
import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class BuildPreviewScreen extends StatelessWidget {
  BuildPreviewScreen({
    super.key,
    required this.motherboard,
    required this.cpu,
    required this.ram,
    required this.psu,
    required this.storage,
    required this.fan,
    required this.gpu
  });

  final user = FirebaseAuth.instance.currentUser;
  final DateFormat dateFormatter = DateFormat.yMMMMEEEEd();

  final String motherboard;
  final String cpu;
  final String ram;
  final String psu;
  final String storage;
  final String fan;
  final String gpu;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "Component Compatibility")
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Screenshot(
                controller: screenshotController,
                child: ReceiptImage(
                  user: user,
                  dateFormatter: dateFormatter,
                  motherboard: motherboard,
                  cpu: cpu,
                  ram: ram,
                  psu: psu,
                  storage: storage,
                  fan: fan,
                  gpu: gpu,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFF6750A4)),
                        foregroundColor: MaterialStatePropertyAll(Colors.white)
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        )
                      ),
                      child: const Text("Back to Home")
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xFF6750A4)),
                        foregroundColor: MaterialStatePropertyAll(Colors.white)
                      ),
                      onPressed: () async {
                        final image = await screenshotController.captureFromWidget(
                          ReceiptImage(
                            user: user,
                            dateFormatter: dateFormatter,
                            motherboard: motherboard,
                            cpu: cpu,
                            ram: ram,
                            psu: psu,
                            storage: storage,
                            fan: fan,
                            gpu: gpu,
                          )
                        );
                        await saveImage(image);
                      },
                      child: const Text("Save to Phone")
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now()
      .toIso8601String()
      .replaceAll(".", "-")
      .replaceAll(":", "-");
    final name = "Receipt $time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }
}

class ReceiptImage extends StatelessWidget {
  const ReceiptImage({
    super.key,
    required this.user,
    required this.dateFormatter,
    required this.motherboard,
    required this.cpu,
    required this.ram,
    required this.psu,
    required this.storage,
    required this.fan,
    required this.gpu
  });

  final User? user;
  final DateFormat dateFormatter;
  final String motherboard;
  final String cpu;
  final String ram;
  final String psu;
  final String storage;
  final String fan;
  final String gpu;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/receipt_bg.png"),
          fit: BoxFit.fill
        )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Build Summary",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const Gap(10),
            Text(
              "PC Build #001 for ${user!.email}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              dateFormatter.format(DateTime.now()),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Column(
                  children: [
                    Text("COMPONENT", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                    Text("Motherboard", style: TextStyle(color: Colors.black),),
                    Text("CPU", style: TextStyle(color: Colors.black),),
                    Text("RAM", style: TextStyle(color: Colors.black),),
                    Text("PSU", style: TextStyle(color: Colors.black),),
                    Text("Storage", style: TextStyle(color: Colors.black),),
                    Text("Fan", style: TextStyle(color: Colors.black),),
                    Text("GPU", style: TextStyle(color: Colors.black),)
                  ],
                ),
                Column(
                  children: [
                    const Text("ITEM", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    Text(motherboard, style: const TextStyle(color: Colors.black),),
                    Text(cpu, style: const TextStyle(color: Colors.black),),
                    Text(ram, style: const TextStyle(color: Colors.black),),
                    Text(psu, style: const TextStyle(color: Colors.black),),
                    Text(storage, style: const TextStyle(color: Colors.black),),
                    Text(fan, style: const TextStyle(color: Colors.black),),
                    Text(gpu, style: const TextStyle(color: Colors.black),),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}