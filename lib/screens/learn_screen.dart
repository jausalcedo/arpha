import 'package:arpha/components/app_drawer.dart';
import 'package:arpha/components/component_card.dart';
import 'package:arpha/components/custom_app_bar.dart';
import 'package:arpha/data/component_learn_list.dart';
import 'package:arpha/models/component_learn_model.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  final List<ComponentLearn> componentLearnList = COMPONENT_LEARN_LIST;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(title: "Learn")
      ),
      drawer: const AppDrawer(),
      body: Container(
        color: const Color(0xffD3E9FE),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/learner.png",
                width: 300,
                fit: BoxFit.contain
              ),
              const SizedBox(height: 30),
              const Text(
                "Welcome to the Learn Section!",
                style: TextStyle(
                  fontSize: 24
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: componentLearnList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemBuilder: (_, index) => ComponentCard(
                    componentLearn: componentLearnList[index]
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}