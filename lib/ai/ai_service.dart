import 'llm_client.dart';

class AIService {
  final LLMClient _client;

  AIService(this._client);

  Future<String> processQuickAdd(String input) async {
    return await _client.generateResponse('Parse todo: $input');
  }

  Future<String> breakdownGoal(String goal) async {
    return await _client.generateResponse('Breakdown goal: $goal');
  }

  Future<String> generateReviewInsights(String todos) async {
    return await _client.generateResponse('Review todos: $todos');
  }
}
