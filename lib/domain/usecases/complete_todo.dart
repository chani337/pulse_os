import '../models/todo.dart';
import '../repositories/todo_repository.dart';
import '../../core/constants/enums.dart';

class CompleteTodo {
  final TodoRepository repository;

  CompleteTodo(this.repository);

  Future<void> call(String todoId) async {
    final todo = await repository.getTodoById(todoId);
    if (todo != null) {
      final updatedTodo = todo.copyWith(
        status: TodoStatus.completed,
        completedAt: DateTime.now(),
      );
      await repository.updateTodo(updatedTodo);
    }
  }
}
