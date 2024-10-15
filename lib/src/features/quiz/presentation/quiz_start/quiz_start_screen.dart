import 'package:flutter/material.dart';
import 'package:flutter_quiz/src/features/quiz/application/quiz_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../common/dropdown.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  final List<String> numberOptions = ["10", "20", "30"];
  late String selectedNumber;

  final List<String> typeOptions = ["Multiple Choice", "True / False"];
  late String selectedType;

  final List<String> difficultyOptions = ["Easy", "Medium", "Hard"];
  late String selectedDifficulty;

  @override
  void initState() {
    super.initState();
    selectedNumber = numberOptions.first;
    selectedType = typeOptions.first;
    selectedDifficulty = difficultyOptions.first;
  }

  navigateToQuestions() {
    final numberOfQuestions = int.parse(selectedNumber);
    final type = (selectedType == "True / False") ? "boolean" : "multiple";
    final difficulty = selectedDifficulty;

    var quizParams = QuizParameters(
      numberOfQuestions: numberOfQuestions,
      type: type,
      difficulty: difficulty,
    );

    ref.read(quizNotifierProvider.notifier).fetchQuestions(quizParams);

    context.go('/quiz');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Welcome to the Quiz App!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Number', textAlign: TextAlign.left),
                Dropdown(
                  items: numberOptions,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedNumber = newValue ?? '';
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text('Type', textAlign: TextAlign.left),
                Dropdown(
                  items: typeOptions,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedType = newValue ?? '';
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text('Difficulty', textAlign: TextAlign.left),
                Dropdown(
                  items: difficultyOptions,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDifficulty = newValue ?? '';
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Start Quiz'),
              onPressed: () => navigateToQuestions(),
            ),
          ],
        ),
      ),
    );
  }
}
