import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../domain/question.dart';

class QuizService {
  final int maxRetries = 3;
  final int initialBackoffDelay = 2000;

  Future<List<Question>> getQuestions({
    int? numberOfQuestions = 10,
    String? type = 'multiple',
    String? difficulty = 'easy',
    int retryCount = 0,
  }) async {
    final queryParameters = {
      'amount': numberOfQuestions.toString(),
      'type': type?.toLowerCase(),
      'difficulty': difficulty?.toLowerCase(),
    };

    final url = Uri.https('www.opentdb.com', 'api.php', queryParameters);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return parseQuestions(response.body);
    } else if (response.statusCode == 429 && retryCount < maxRetries) {
      return await _handleTooManyRequest(numberOfQuestions, type, difficulty, retryCount);
    } else {
      throw Exception('Failed to load questions. Status Code: ${response.statusCode.toString()}');
    }
  }

  List<Question> parseQuestions(String responseBody) {
    final data = json.decode(responseBody);
    return (data['results'] as List).map((questionData) => Question.fromJson(questionData)).toList();
  }

  Future<List<Question>> _handleTooManyRequest(numberOfQuestions, type, difficulty, retryCount) async {
    final delay = initialBackoffDelay * pow(2, retryCount).toInt();

    await Future.delayed(Duration(milliseconds: delay));
    return await getQuestions(
        numberOfQuestions: numberOfQuestions, type: type, difficulty: difficulty, retryCount: retryCount + 1);
  }
}
