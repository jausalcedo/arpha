import 'package:arpha/models/component_learn_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComponentCard extends StatelessWidget {
  const ComponentCard({
    super.key,
    required this.componentLearn,
  });

  final ComponentLearn componentLearn;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: componentLearn.color,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                componentLearn.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(componentLearn.title),
          onTap: () => showModalBottomSheet(
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          )
        ),
      ),
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
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
            ),
            Text(
              content,
              style: const TextStyle(
                color: Colors.white
              )
            ),
          ],
        ),
      ),
    );
  }
}