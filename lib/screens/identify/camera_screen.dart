import 'package:arpha/components/app_drawer.dart';
import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/main.dart';
import 'package:arpha/screens/identify/identify_result_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("Access was denied.");
            break;
          default: print(e.description);
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "Identify"),
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 16 / 9,
            child: CameraPreview(controller),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: MaterialButton(
                    onPressed: () async {
                      if (!controller.value.isInitialized) {
                        return;
                      }
                      if (controller.value.isTakingPicture) {
                        return;
                      }
                      
                      try {
                        await controller.setFlashMode(FlashMode.off);
                        XFile file = await controller.takePicture();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => IdentifyResultScreen(file))
                        );
                      } on CameraException catch (e) {
                        debugPrint("Error occured while taking picture : $e");
                        return;
                      }
                    },
                    color: Colors.white,
                    child: const Text("Capture"),
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}