import 'package:arpha/components/app_drawer.dart';
import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/data/cpu_list.dart';
import 'package:arpha/data/fan_list.dart';
import 'package:arpha/data/gpu_list.dart';
import 'package:arpha/data/motherboard_list.dart';
import 'package:arpha/data/psu_list.dart';
import 'package:arpha/data/ram_list.dart';
import 'package:arpha/data/storage_dropdownbutton.dart';
import 'package:arpha/helpers/dbhelper.dart';
import 'package:arpha/models/component_models.dart';
import 'package:arpha/screens/build_preview_screen.dart';
import 'package:arpha/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CompatibilityScreen extends StatefulWidget {
  const CompatibilityScreen({super.key});

  @override
  State<CompatibilityScreen> createState() => _CompatibilityScreenState();
}

class _CompatibilityScreenState extends State<CompatibilityScreen> {
  PageController pageController = PageController();

  bool onLastPage = false;
  bool notFirstPage = false;

  final List<Motherboard> motherboardList = MOTHERBOARD_LIST;
  final List<CPU> cpuList = CPU_LIST;
  final List<RAM> ramList = RAM_LIST;
  final List<Storage> storageList = STORAGE_LIST;
  final List<PSU> psuList = PSU_LIST;
  final List<Fan> fanList = FAN_LIST;
  final List<GPU> gpuList = GPU_LIST;

  List<CPU> cpuListForSelectedMotherboard = [];
  List<RAM> ramListForSelectedMotherboard = [];
  List<Storage> storageListForSelectedMotherboard = [];
  List<PSU> psuListForSelectedMotherboard = [];
  List<Fan> fanListForSelectedMotherboard = [];
  List<GPU> gpuListForSelectedMotherboard = [];

  Motherboard? selectedMotherboard;
  CPU? selectedCPU;
  RAM? selectedRAM;
  Storage? selectedStorage;
  PSU? selectedPSU;
  Fan? selectedFan;
  GPU? selectedGPU;

  bool motherboardOk = false;
  bool cpuOk = false;
  bool ramOk = false;
  bool storageOk = false;
  bool psuOk = false;
  bool fanOk = false;
  bool gpuOk = false;

  bool allOk = false;

  String? userEmail = FirebaseAuth.instance.currentUser!.email;

  DateTime now = DateTime.now();

  String formattedDateTime = "";

  Widget showErrorMessage(String errrorMessage) {
    formattedDateTime = DateFormat.yMMMMEEEEd().format(now);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Error",
          style: TextStyle(fontSize: 20),
        ),
        Text(errrorMessage),
        const Gap(20),
        ElevatedButton(
          onPressed: () => pageController.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn
          ),
          child: const Text("Go back")
        )
      ],
    );
  }

  List<CPU> filterCPUBySocket(String param) {
    return cpuList.where((item) => item.socket == param).toList();
  }

  List<RAM> filterRAMByType(String param) {
    return ramList.where((item) => item.type == param).toList();
  }

  List<Storage> filterStorageBySataType(String param) {
    return storageList.where((item) => item.sataType == param).toList();
  }

  List<PSU> filterPSUByFormFactor(String param) {
    return psuList.where((item) => item.formFactor == param).toList();
  }

  List<Fan> filterFanByPinType(int param) {
    return fanList.where((item) => item.pinType == param).toList();
  }

  List<GPU> filterGPUByBus(String param) {
    return gpuList.where((item) => item.bus == param).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(title: "Compatibility Checker")),
      drawer: const AppDrawer(),
      body: Stack(children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 6);
              notFirstPage = (index != 0);
            });
          },
          controller: pageController,
          children: [
            // Motherboard
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  Image.asset('assets/images/learn/MOTHERBOARD.png', width: 300),
                  const Gap(20),
                  Text(selectedMotherboard == null ? "Select a Motherboard below:" : "Selected Motherboard:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<Motherboard>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedMotherboard,
                      items: motherboardList
                        .map((item) => DropdownMenuItem<Motherboard>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedMotherboard = item;
                          motherboardOk = true;
                          selectedCPU = null;
                          selectedRAM = null;
                          cpuOk = false;
                          ramOk = false;
                        });

                        List<CPU> filteredCPUs = filterCPUBySocket(item!.socket);

                        if (filteredCPUs.isNotEmpty) {
                          setState(() {
                            cpuListForSelectedMotherboard = filteredCPUs;
                          });
                        }

                        List<RAM> filteredRAMs = filterRAMByType(item.memoryType);

                        if (filteredRAMs.isNotEmpty) {
                          setState(() {
                           ramListForSelectedMotherboard = filteredRAMs;
                          });
                        }

                        List<Storage> filteredStorages = filterStorageBySataType(item.sataType);

                        if (filteredStorages.isNotEmpty) {
                          setState(() {
                           storageListForSelectedMotherboard = filteredStorages;
                          });
                        }

                        List<PSU> filteredPSUs = filterPSUByFormFactor(item.formFactor);

                        if (filteredPSUs.isNotEmpty) {
                          setState(() {
                           psuListForSelectedMotherboard = filteredPSUs;
                          });
                        }

                        List<Fan> filteredFans = filterFanByPinType(item.fanPinType);

                        if (filteredFans.isNotEmpty) {
                          setState(() {
                           fanListForSelectedMotherboard = filteredFans;
                          });
                        }

                        List<GPU> filteredGPUs = filterGPUByBus(item.bus);

                        if (filteredGPUs.isNotEmpty) {
                          setState(() {
                           gpuListForSelectedMotherboard = filteredGPUs;
                          });
                        }
                      }
                    ),
                  ),
                ],
              ),
            ),
            // CPU
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green.shade100,
              child: !motherboardOk
              ? showErrorMessage("Please select a Motherboard before proceeding.")
              : Column(
                children: [
                  Image.asset('assets/images/learn/CPU.png', width: 300),
                  const Gap(20),
                  Text(selectedCPU == null ? "Select a CPU below" : "Selected CPU:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<CPU>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedCPU,
                      items: cpuListForSelectedMotherboard
                        .map((item) => DropdownMenuItem<CPU>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: motherboardOk ? (item) {
                        setState(() {
                          selectedCPU = item;
                          cpuOk = true;
                        });
                      } : null
                    ),
                  ),
                ],
              ),
            ),
            // RAM
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green.shade200,
              child: !cpuOk
                ? showErrorMessage("Please select a CPU before proceeding.")
                : Column(
                children: [
                  Image.asset('assets/images/learn/RAM.png', width: 300),
                  const Gap(20),
                  Text(selectedMotherboard == null ? "Select a RAM below:" : "Selected RAM:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<RAM>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedRAM,
                      items: ramListForSelectedMotherboard
                        .map((item) => DropdownMenuItem<RAM>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedRAM = item;
                          ramOk = true;
                        });
                      }
                    ),
                  ),
                ],
              ),
            ),
            // Storage
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green.shade300,
              child: !ramOk
                ? showErrorMessage("Please select a RAM before proceeding.")
                : Column(
                children: [
                  Image.asset('assets/images/learn/STORAGE.png', width: 300),
                  const Gap(20),
                  Text(selectedMotherboard == null ? "Select a Storage below:" : "Selected Storage:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<Storage>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedStorage,
                      items: storageListForSelectedMotherboard
                        .map((item) => DropdownMenuItem<Storage>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedStorage = item;
                          storageOk = true;
                        });
                      }
                    ),
                  ),
                ],
              ),
            ),
            // PSU
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green.shade400,
              child: !storageOk
                ? showErrorMessage("Please select a Storage before proceeding.")
                : Column(
                children: [
                  Image.asset('assets/images/learn/PSU.png', width: 300),
                  const Gap(20),
                  Text(selectedMotherboard == null ? "Select a PSU below:" : "Selected PSU:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<PSU>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedPSU,
                      items: psuListForSelectedMotherboard
                        .map((item) => DropdownMenuItem<PSU>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedPSU = item;
                          psuOk = true;
                        });
                      }
                    ),
                  ),
                ],
              ),
            ),
            // Fan
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green.shade500,
              child: !psuOk
                ? showErrorMessage("Please select a PSU before proceeding.")
                : Column(
                children: [
                  Image.asset('assets/images/learn/FAN.png', width: 300),
                  const Gap(20),
                  Text(selectedMotherboard == null ? "Select a Fan below:" : "Selected Fan:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<Fan>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedFan,
                      items: fanListForSelectedMotherboard
                        .map((item) => DropdownMenuItem<Fan>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedFan = item;
                          fanOk = true;
                        });
                      }
                    ),
                  ),
                ],
              ),
            ),
            // GPU
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.green.shade600,
              child: !fanOk
                ? showErrorMessage("Please select a Fan before proceeding.")
                : Column(
                children: [
                  Image.asset('assets/images/learn/GPU.png', width: 300),
                  const Gap(20),
                  Text(selectedMotherboard == null ? "Select a GPU below:" : "Selected GPU:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<GPU>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedGPU,
                      items: gpuListForSelectedMotherboard
                        .map((item) => DropdownMenuItem<GPU>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedGPU = item;
                          gpuOk = true;
                          allOk = true;
                        });
                      }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Container(
          alignment: const Alignment(0, 0.9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              notFirstPage
              ? GestureDetector(
                onTap: () => pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn
                ),
                child: const Text(
                  "Back",
                  style: TextStyle(fontSize: 20),
                )
              )
              : GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  )
                ),
                child: const Text(
                  "Home",
                  style: TextStyle(fontSize: 20),
                )
              ),
              SmoothPageIndicator(
                controller: pageController,
                count: 7
              ),
              onLastPage
              ? GestureDetector(
                onTap: allOk
                  ? () async {
                    await DbHelper.insertBuild({
                      DbHelper.colUserEmail : userEmail,
                      DbHelper.colMotherboard : selectedMotherboard!.name,
                      DbHelper.colCPU : selectedCPU!.name,
                      DbHelper.colRAM : selectedRAM!.name,
                      DbHelper.colStorage : selectedStorage!.name,
                      DbHelper.colPSU : selectedPSU!.name,
                      DbHelper.colFan : selectedFan!.name,
                      DbHelper.colGPU : selectedGPU!.name,
                      DbHelper.colDateTime : formattedDateTime
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BuildPreviewScreen(
                        motherboard: selectedMotherboard!.name,
                        cpu: selectedCPU!.name,
                        ram: selectedRAM!.name,
                        psu: selectedPSU!.name,
                        storage: selectedStorage!.name,
                        fan: selectedFan!.name,
                        gpu: selectedGPU!.name
                      ),
                    )
                  );
                  }
                  : null,
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 20),
                )
              )
              : GestureDetector(
                onTap: () => pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 20),
                )
              )
            ]
          )
        )
      ]),
    );
  }
}
