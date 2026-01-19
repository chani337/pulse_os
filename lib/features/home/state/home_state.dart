import '../../../domain/models/todo.dart';

class HomeState {
  final List<Todo> todos;
  final bool isLoading;

  const HomeState({
    this.todos = const [],
    this.isLoading = false,
  });

  HomeState copyWith({
    List<Todo>? todos,
    bool? isLoading,
  }) {
    return HomeState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
