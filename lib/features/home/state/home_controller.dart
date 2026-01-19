import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/todo_repository_impl.dart';
import '../../../domain/models/todo.dart';
import '../../../domain/repositories/todo_repository.dart';
import '../../../engines/rules/recommendation_rules.dart';
import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(this._repository) : super(const HomeState());

  final TodoRepository _repository;

  Future<void> loadTodos() async {
    state = state.copyWith(isLoading: true);
    final todos = await _repository.getAllTodos();
    final recommended = RecommendationRules.getRecommendedTodos(todos);
    state = state.copyWith(todos: recommended, isLoading: false);
  }

  Future<void> refresh() async {
    await loadTodos();
  }
}

final todoRepositoryProvider = Provider<TodoRepository>(
  (ref) => TodoRepositoryImpl(),
);

final homeControllerProvider =
    StateNotifierProvider<HomeController, HomeState>(
  (ref) => HomeController(ref.read(todoRepositoryProvider)),
);
