import '../../../domain/models/todo.dart';

class ReviewInsightsRules {
  static Map<String, dynamic> generateInsights(List<Todo> todos) {
    final completed = todos.where((todo) => todo.status.name == 'completed').length;
    final total = todos.length;
    final completionRate = total > 0 ? (completed / total * 100) : 0.0;

    return {
      'totalTodos': total,
      'completedTodos': completed,
      'completionRate': completionRate,
    };
  }
}
