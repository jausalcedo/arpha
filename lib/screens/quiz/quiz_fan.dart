import 'dart:async';
import 'package:arpha/components/for_quiz/option_card.dart';
import 'package:arpha/components/for_quiz/question_widget.dart';
import 'package:arpha/components/for_quiz/result_box.dart';
import 'package:arpha/constants/quiz_colors.dart';
import 'package:arpha/helpers/db_connect.dart';
import 'package:arpha/models/question_model.dart';
import 'package:arpha/screens/home_screen.dart';
import 'package:arpha/screens/quiz/quiz_home.dart';
import 'package:flutter/material.dart';

class QuizFanScreen extends StatefulWidget {
  const QuizFanScreen({Key? key}) : super(key: key);

  @override
  QuizFanScreenState createState() => QuizFanScreenState();
}

class QuizFanScreenState extends State<QuizFanScreen> {
  var db = DBconnect();
  late Future<List<Question>> _questions;
  late List<Question> extractedData;

  late Timer _timer;
  int _timerDuration = 0;
  int elapsedTime = 0;

  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  bool _durationDialogShown = false;

  @override
  void initState() {
    super.initState();
    _questions = getData();
    Future.delayed(Duration.zero, _showDurationDialog);
  }

  Future<List<Question>> getData() async {
    List<Question> questions = await db.fetchQuestions("https://arpha-d4a14-default-rtdb.firebaseio.com/fan.json");
    questions.shuffle();
    return questions.take(10).toList();
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
          elapsedTime++;
        } else {
          timer.cancel();
          _showTimeUpDialog();
        }
      });
    });
  }

  void _showDurationDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Select Quiz Duration"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: durations.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _initializeData(durations[index]);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(durations[index]),
                ),
                child: Text(
                  "${durations[index]} seconds",
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<int> durations = [200, 100, 60];

  Color _getButtonColor(int duration) {
    switch (duration) {
      case 200:
        return Colors.green;
      case 100:
        return Colors.blue;
      case 60:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => ResultBox(
        result: score,
        questionLength: extractedData.length,
        elapsedTime: elapsedTime,
        onPressed: startOver,
        isTimeUp: true,
      ),
    );
  }

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      _timer.cancel();
      _showResultDialog();
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select any option'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20.0),
          ),
        );
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        if (index == extractedData.length - 1) {
          _timer.cancel();
          _showResultDialog();
        } else {
          setState(() {
            index++;
            isPressed = false;
            isAlreadySelected = false;
          });
        }
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
      elapsedTime = 0;
      _durationDialogShown = false;
    });

    Navigator.of(context, rootNavigator: true).pop();

    _questions = getData();
    if (!_durationDialogShown) {
      _showDurationDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Column(
        children: [
          ResultBox(
            result: score,
            questionLength: extractedData.length,
            elapsedTime: elapsedTime,
            onPressed: startOver,
            isTimeUp: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const QuizHomeScreen())
                  ),
                  child: const Text('Quiz Type')
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen())
                  ),
                  child: const Text('Home')
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _initializeData([int duration = 60]) async {
    extractedData = await getData();
    _timerDuration = duration;
    elapsedTime = 0;
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: Row(
                  children: [
                    const Text(
                      'Quiz: Fan',
                      style: TextStyle(
                        fontSize: 17
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Time: $_timerDuration s',
                        style: const TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
                backgroundColor: background,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView(
                  children: [
                    QuestionWidget(
                      indexAction: index,
                      question: extractedData[index].title,
                      totalQuestions: extractedData.length,
                    ),
                    const Divider(color: neutral),
                    const SizedBox(height: 25.0),
                    for (int i = 0; i < extractedData[index].option.length; i++)
                      GestureDetector(
                        onTap: () {
                          checkAnswerAndUpdate(extractedData[index].option.values.toList()[i]);
                        },
                        child: OptionCard(
                          option: extractedData[index].option.keys.toList()[i],
                          color: isPressed
                              ? extractedData[index].option.values.toList()[i] == true
                                  ? correct
                                  : incorrect
                              : neutral,
                        ),
                      ),
                  ],
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20.0),
                Text(
                  'Please Wait while Questions are loading..',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.none,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
