import '../../../domain/models/todo.dart';
import '../../../domain/repositories/todo_repository.dart';
import '../local/hive/boxes.dart';

class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<List<Todo>> getAllTodos() async {
    final box = HiveBoxes.todosBox;
    return box.values.cast<Todo>().toList();
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    final box = HiveBoxes.todosBox;
    return box.get(id) as Todo?;
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final box = HiveBoxes.todosBox;
    await box.put(todo.id, todo);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final box = HiveBoxes.todosBox;
    await box.put(todo.id, todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final box = HiveBoxes.todosBox;
    await box.delete(id);
  }

  @override
  Future<List<Todo>> getTodosByStatus(String status) async {
    final allTodos = await getAllTodos();
    return allTodos.where((todo) => todo.status.name == status).toList();
  }
}
