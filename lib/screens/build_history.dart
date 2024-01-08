import 'package:arpha/components/app_drawer.dart';
import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/helpers/dbhelper.dart';
import 'package:flutter/material.dart';

class BuildHistory extends StatelessWidget {
  const BuildHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "Build History")
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: DbHelper.fetchBuilds(),
        builder: (context, snapshot) {
          var builds = snapshot.data;
          if (builds == null || builds.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Build History Empty")
                ],
              ),
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: builds.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Build #${builds[index][DbHelper.colBuildId]}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(builds[index][DbHelper.colDateTime]),
                            ),
                            ListTile(
                              title: Text(builds[index][DbHelper.colMotherboard]),
                              subtitle: Text(DbHelper.colMotherboard.toUpperCase()),
                            ),
                            ListTile(
                              title: Text(builds[index][DbHelper.colCPU]),
                              subtitle: Text(DbHelper.colCPU.toUpperCase()),
                            ),
                            ListTile(
                              title: Text(builds[index][DbHelper.colRAM]),
                              subtitle: Text(DbHelper.colRAM.toUpperCase()),
                            ),
                            ListTile(
                              title: Text(builds[index][DbHelper.colStorage]),
                              subtitle: Text(DbHelper.colStorage.toUpperCase()),
                            ),
                            ListTile(
                              title: Text(builds[index][DbHelper.colPSU]),
                              subtitle: Text(DbHelper.colPSU.toUpperCase()),
                            ),
                            ListTile(
                              title: Text(builds[index][DbHelper.colFan]),
                              subtitle: Text(DbHelper.colFan.toUpperCase()),
                            ),
                            ListTile(
                              title: Text(builds[index][DbHelper.colGPU]),
                              subtitle: Text(DbHelper.colGPU.toUpperCase()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}