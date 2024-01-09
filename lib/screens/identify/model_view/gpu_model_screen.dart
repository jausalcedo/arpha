import 'package:arpha/components/app_drawer.dart';
import 'package:arpha/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class GpuModelScreen extends StatelessWidget {
  const GpuModelScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "ARPHA")
      ),
      drawer: AppDrawer(),
      body: ModelViewer(
        src: 'assets/object_detection/identify/gpu_identify.glb',
        ar: true,
        autoRotate: true,
        disableZoom: true,
      )
    );
  }
}