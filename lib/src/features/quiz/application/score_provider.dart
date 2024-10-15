import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score_provider.g.dart';

@Riverpod(keepAlive: true)
class ScoreNotifier extends _$ScoreNotifier {
  @override
  int build() => 0;

  void incrementScore() => state++;

  void reset() => state = 0;
}
