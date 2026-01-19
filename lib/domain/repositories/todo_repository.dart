import '../models/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getAllTodos();
  Future<Todo?> getTodoById(String id);
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<List<Todo>> getTodosByStatus(String status);
}
