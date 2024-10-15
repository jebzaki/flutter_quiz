import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/quiz_provider.dart';
import '../../application/question_provider.dart';
import 'question_card.dart';

class QuestionsScreen extends ConsumerStatefulWidget {
  // Constructor
  const QuestionsScreen({super.key});

  @override
  ConsumerState<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends ConsumerState<QuestionsScreen> {
  late final QuizParameters quizParams;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quizAsyncValue = ref.watch(quizNotifierProvider);
    final currentQuestionIndex = ref.watch(currentQuestionIndexProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: quizAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (questions) {
          if (questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (currentQuestionIndex >= questions.length) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/result');
            });
            return const SizedBox.shrink();
          }
          return QuestionCard(
            question: questions[currentQuestionIndex],
            currentQuestionNumber: currentQuestionIndex + 1,
          );
        },
      ),
    );
  }
}
