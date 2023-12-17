import 'package:arpha/models/question_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DBconnect {
  Future<List<Question>> fetchQuestions(String url) async {
    return http.get(Uri.parse(url)).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
          id: key,
          title: value['title'],
          option: Map.castFrom(value['option']),
        );
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }
}
