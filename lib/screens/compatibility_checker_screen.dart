import 'package:arpha/components/app_drawer.dart';
import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/data/cpu_list.dart';
import 'package:arpha/data/fan_list.dart';
import 'package:arpha/data/gpu_list.dart';
import 'package:arpha/data/motherboard_list.dart';
import 'package:arpha/data/psu_list.dart';
import 'package:arpha/data/ram_list.dart';
import 'package:arpha/data/storage_dropdownbutton.dart';
import 'package:arpha/models/component_models.dart';
import 'package:arpha/screens/build_preview_screen.dart';
import 'package:flutter/material.dart';

class CompatibilityCheckerScreen extends StatefulWidget {
  const CompatibilityCheckerScreen({super.key});

  @override
  State<CompatibilityCheckerScreen> createState() => _CompatibilityCheckerScreenState();
}

class _CompatibilityCheckerScreenState extends State<CompatibilityCheckerScreen> {
  final List<Motherboard> mobotherboardList = MOTHERBOARD_LIST;
  final List<CPU> cpuList = CPU_LIST;
  final List<RAM> ramList = RAM_LIST;
  final List<Storage> storageList = STORAGE_LIST;
  final List<PSU> psuList = PSU_LIST;
  final List<Fan> fanList = FAN_LIST;
  final List<GPU> gpuList = GPU_LIST;

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
  bool? gpuOk;

  bool allOk = false;

  void showErrorDialog(String errrorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(errrorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Try again.")
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "Compatibility Checker"),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // motherboard dropdownbutton
                  Text(selectedMotherboard == null ? "Select a Motherboard below:" : "Selected Motherboard:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<Motherboard>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedMotherboard,
                      items: mobotherboardList
                        .map((item) => DropdownMenuItem<Motherboard>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() => selectedMotherboard = item);
                        if ((selectedMotherboard != null && selectedCPU != null) && (selectedMotherboard!.socket != selectedCPU!.socket)) {
                          showErrorDialog("Selected Motherboard is incompatible with the selected CPU.");
                          motherboardOk = false;
                        } else if ((selectedMotherboard != null && selectedRAM != null) && (selectedMotherboard!.memoryType != selectedRAM!.type)) {
                          showErrorDialog("Selected Motherboard is incompatible with the selected RAM.");
                          motherboardOk = false;
                        } else if ((selectedMotherboard != null && selectedStorage != null) && (selectedMotherboard!.sataType != selectedStorage!.sataType)) {
                          showErrorDialog("Selected Motherboard is incompatible with the selected Storage");
                          motherboardOk = false;
                        } else if ((selectedMotherboard != null && selectedPSU != null) && (selectedMotherboard!.formFactor != selectedPSU!.formFactor)) {
                          showErrorDialog("Selected Motherboard is incompatible with the selected PSU");
                          motherboardOk = false;
                        } else if ((selectedMotherboard != null && selectedFan != null) && (selectedMotherboard!.fanPinType != selectedFan!.pinType)) {
                          showErrorDialog("Selected Motherboard is incompatible with the selected Fan");
                          motherboardOk = false;
                        } else if ((selectedMotherboard != null && selectedGPU != null) && (selectedMotherboard!.bus != selectedGPU!.bus)) {
                          showErrorDialog("Selected Motherboard is incompatible with the selected Fan");
                          motherboardOk = false;
                        } else {
                          motherboardOk = true;
                        }
                      }
                    ),
                  ),
                  // cpu dropdownbutton
                  Text(selectedCPU == null ? "Select a CPU below" : "Selected CPU:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<CPU>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedCPU,
                      items: cpuList
                        .map((item) => DropdownMenuItem<CPU>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() => selectedCPU = item!);
                        if ((selectedMotherboard != null && selectedCPU != null) && (selectedMotherboard!.socket != selectedCPU!.socket)) {
                          showErrorDialog("Selected CPU socket is incompatible with the selected Motherboard socket.");
                          cpuOk = false; 
                        } else {
                          cpuOk = true;
                        }
                      }
                    ),
                  ),
                  // ram dropdownbutton
                  Text(selectedRAM == null ? "Select a RAM below:" : "Selected RAM:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<RAM>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedRAM,
                      items: ramList
                        .map((item) => DropdownMenuItem<RAM>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() => selectedRAM = item!);
                        if ((selectedMotherboard != null && selectedRAM != null) && (selectedMotherboard!.memoryType != selectedRAM!.type)) {
                          showErrorDialog("Selected RAM is incompatible with the selected Motherboard.");
                          ramOk = false;
                        } else {
                          ramOk = true;
                        }
                      }
                    ),
                  ),
                  // storage dropdownbutton
                  Text(selectedRAM == null ? "Select a Storage below:" : "Selected Storage:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<Storage>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedStorage,
                      items: storageList
                        .map((item) => DropdownMenuItem<Storage>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() => selectedStorage = item!);
                        if ((selectedMotherboard != null && selectedStorage != null) && (selectedMotherboard!.sataType != selectedStorage!.sataType)) {
                          showErrorDialog("Selected Storage is incompatible with the selected Motherboard");
                          storageOk = false;
                        } else {
                          storageOk = true;
                        }
                      }
                    ),
                  ),
                  // psu dropdownbutton
                  Text(selectedPSU == null ? "Select a PSU below:" : "Selected PSU:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<PSU>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedPSU,
                      items: psuList
                        .map((item) => DropdownMenuItem<PSU>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() => selectedPSU = item!);
                        if ((selectedMotherboard != null && selectedPSU != null) && (selectedMotherboard!.formFactor != selectedPSU!.formFactor)) {
                          showErrorDialog("Selected PSU is incompatible with the selected Motherboard");
                          psuOk = false;
                        } else {
                          psuOk = true;
                        }
                      }
                    ),
                  ),
                  // fan dropdownbutton
                  Text(selectedPSU == null ? "Select a Fan below:" : "Selected Fan:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<Fan>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedFan,
                      items: fanList
                        .map((item) => DropdownMenuItem<Fan>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() => selectedFan = item!);
                        if ((selectedMotherboard != null && selectedFan != null) && (selectedMotherboard!.fanPinType != selectedFan!.pinType)) {
                          showErrorDialog("Selected Fan is incompatible with the selected Motherboard");
                          fanOk = false;
                        } else {
                          fanOk = true;
                        }
                      }
                    ),
                  ),
                  // gpu dropdownbutton
                  Text(selectedPSU == null ? "Select a GPU below:" : "Selected GPU:"),
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: DropdownButtonFormField<GPU>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(width: 2, color: Colors.blue)
                        ) 
                      ),
                      value: selectedGPU,
                      items: gpuList
                        .map((item) => DropdownMenuItem<GPU>(
                          value: item,
                          child: Text(item.name, style: const TextStyle(fontSize: 14),),
                        )).toList(),
                      onChanged: (item) {
                        setState(() => selectedGPU = item!);
                        if ((selectedMotherboard != null && selectedGPU != null) && (selectedMotherboard!.bus != selectedGPU!.bus)) {
                          showErrorDialog("Selected GPU is incompatible with the selected Motherboard");
                          gpuOk = false;
                        } else {
                          gpuOk = true;
                        }
                      }
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: (){
                        if (
                          motherboardOk &&
                          cpuOk &&
                          ramOk &&
                          storageOk &&
                          psuOk &&
                          fanOk
                        ) allOk = true;
            
                        if (allOk) {
                          Navigator.push(
                            context,
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
                        } else {
                          showErrorDialog("Some components are still incompatible. Please review them before proceeding with the build preview.");
                        }
                      },
                      child: const Text("Build It!")
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}