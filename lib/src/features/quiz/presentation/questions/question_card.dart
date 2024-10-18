import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/question.dart';
import '../../application/question_provider.dart';
import '../../application/score_provider.dart';
import 'answer_button.dart';

class QuestionCard extends ConsumerWidget {
  final Question question;
  final int currentQuestionNumber;

  const QuestionCard({super.key, required this.question, required this.currentQuestionNumber});

  List<String> _generateAnswers(Question question) {
    if (question.type == 'boolean') {
      return ['True', 'False'];
    }

    return [...question.incorrectAnswers, question.correctAnswer]..shuffle();
  }

  Widget _generateAnswersList(WidgetRef ref, List<String> answers) {
    return Flexible(
        flex: 4,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          ...answers.map((answer) => AnswerButton(
                answer: answer,
                onPressed: () {
                  if (answer == question.correctAnswer) {
                    ref.read(scoreNotifierProvider.notifier).incrementScore();
                  }
                  ref.read(currentQuestionIndexProvider.notifier).nextQuestion();
                },
              )),
        ]));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> answers = _generateAnswers(question);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
              flex: 1,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "#${currentQuestionNumber.toString()}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    question.question,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ],
              )),
          const SizedBox(height: 20),
          _generateAnswersList(ref, answers)
        ],
      ),
    );
  }
}
