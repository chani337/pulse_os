import '../models/todo.dart';
import '../repositories/todo_repository.dart';

class GetRecommendedTodos {
  final TodoRepository repository;

  GetRecommendedTodos(this.repository);

  Future<List<Todo>> call() async {
    final allTodos = await repository.getAllTodos();
    final pendingTodos = allTodos.where((todo) => todo.status.name == 'pending').toList();
    return pendingTodos;
  }
}
