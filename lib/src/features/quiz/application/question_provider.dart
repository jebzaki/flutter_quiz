import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_provider.g.dart';

@riverpod
class CurrentQuestionIndex extends _$CurrentQuestionIndex {
  @override
  int build() => 0;

  void nextQuestion() => state++;
}
