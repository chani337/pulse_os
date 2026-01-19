import '../models/todo.dart';
import '../repositories/todo_repository.dart';
import '../../core/constants/enums.dart';

class PostponeTodo {
  final TodoRepository repository;

  PostponeTodo(this.repository);

  Future<void> call(String todoId, DateTime newDueDate) async {
    final todo = await repository.getTodoById(todoId);
    if (todo != null) {
      final updatedTodo = todo.copyWith(
        status: TodoStatus.postponed,
        dueDate: newDueDate,
      );
      await repository.updateTodo(updatedTodo);
    }
  }
}
