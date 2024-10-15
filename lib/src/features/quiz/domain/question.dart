import 'package:html_unescape/html_unescape.dart';

class Question {
  final String question;
  final List<String> incorrectAnswers;
  final String correctAnswer;
  final String type;

  Question({
    required this.question,
    required this.incorrectAnswers,
    required this.correctAnswer,
    required this.type,
  });

  factory Question.fromJson(Map<String, dynamic> jsonData) {
    final unescape = HtmlUnescape();

    List<String> incorrectAnswers =
        (jsonData['incorrect_answers'] as List<dynamic>)
            .map((item) => unescape.convert(item))
            .toList();

    return Question(
      question: unescape.convert(jsonData['question']),
      incorrectAnswers: incorrectAnswers,
      correctAnswer: unescape.convert(jsonData['correct_answer']),
      type: unescape.convert(jsonData['type']),
    );
  }
}
