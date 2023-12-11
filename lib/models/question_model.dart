class NoviceQuestion {
  String question;
  List<String> choices;
  String answer;

  NoviceQuestion({
    required this.question,
    required this.choices,
    required this.answer
  });
}

class IntermediateQuestion {

}

NoviceQuestion one = NoviceQuestion(
  question: "question",
  choices: [
    "A",
    "B",
    "C",
    "D"
  ],
  answer: "answer",
);