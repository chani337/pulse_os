import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(const HomeState());

  void loadTodos() {
    // Load todos logic
  }

  void refresh() {
    loadTodos();
  }
}

final homeControllerProvider =
    StateNotifierProvider<HomeController, HomeState>(
  (ref) => HomeController(),
);
