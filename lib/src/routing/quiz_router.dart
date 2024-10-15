import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../features/quiz/presentation/quiz_start/quiz_start_screen.dart';
import '../features/quiz/presentation/questions/questions_screen.dart';
import '../features/quiz/presentation/result/result_screen.dart';

part 'quiz_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const StartScreen(),
      ),
      GoRoute(
        path: '/quiz',
        builder: (context, state) => const QuestionsScreen(),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) => const ResultScreen(),
      ),
    ],
  );
}
