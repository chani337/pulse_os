import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/home_controller.dart';
import '../widgets/now_context_bar.dart';
import '../widgets/todo_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(homeControllerProvider.notifier).loadTodos());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulse OS'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(homeControllerProvider.notifier).refresh(),
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const NowContextBar(
                    contextText: '지금 가능한 시간/에너지를 알려주세요',
                  ),
                  const SizedBox(height: 16),
                  if (state.todos.isEmpty)
                    Text(
                      '추천할 일이 없어요. 인박스에 새 할 일을 추가해보세요.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  else
                    ...state.todos.map(
                      (todo) => TodoCard(todo: todo),
                    ),
                ],
              ),
            ),
    );
  }
}
