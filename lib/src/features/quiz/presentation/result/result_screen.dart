import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/quiz_provider.dart';
import '../../application/score_provider.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(quizNotifierProvider);
    final score = ref.watch(scoreNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Results')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Quiz Finished!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text('Your score: $score / ${questions.value?.length}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Start New Quiz'),
              onPressed: () {
                ref.read(scoreNotifierProvider.notifier).reset();
                ref.read(quizNotifierProvider.notifier).reset();
                ref.read(quizNotifierProvider.notifier).fetchQuestions(null);
                context.go('/quiz');
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Back to Start'),
              onPressed: () {
                ref.read(scoreNotifierProvider.notifier).reset();
                context.go('/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
