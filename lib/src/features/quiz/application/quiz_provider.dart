import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/question.dart';
import '../data/quiz_service.dart';

part 'quiz_provider.g.dart';

class QuizParameters {
  final int? numberOfQuestions;
  final String? type;
  final String? difficulty;

  const QuizParameters({
    this.numberOfQuestions,
    this.type,
    this.difficulty,
  });
}

@Riverpod(keepAlive: true)
class QuizNotifier extends _$QuizNotifier {
  QuizParameters? _params;

  @override
  Future<List<Question>> build() async {
    state = const AsyncLoading();
    return [];
  }

  Future<void> fetchQuestions(QuizParameters? params) async {
    state = const AsyncLoading();

    if (params == null && _params == null) {
      state = AsyncError("Invalid parameters used", StackTrace.current);
      throw Exception('Invalid parameters used');
    }

    // If params is null, assign _params to it (assuming _params is non-null).
    params ??= _params;

    // If params is not null, update _params.
    _params ??= params;

    final quizService = QuizService();

    try {
      final questions = await quizService.getQuestions(
        numberOfQuestions: params?.numberOfQuestions,
        type: params?.type,
        difficulty: params?.difficulty,
      );
      state = AsyncData(questions);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  void reset() => state = const AsyncData([]);
}
