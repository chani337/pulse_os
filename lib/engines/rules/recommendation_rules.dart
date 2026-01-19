import '../../../domain/models/todo.dart';
import '../../../core/constants/enums.dart';

class RecommendationRules {
  static List<Todo> getRecommendedTodos(List<Todo> todos) {
    final pendingTodos = todos.where((todo) => todo.status == TodoStatus.pending).toList();
    
    // Sort by priority and due date
    pendingTodos.sort((a, b) {
      if (a.priority != b.priority) {
        return b.priority.index.compareTo(a.priority.index);
      }
      if (a.dueDate != null && b.dueDate != null) {
        return a.dueDate!.compareTo(b.dueDate!);
      }
      return 0;
    });

    return pendingTodos;
  }
}
