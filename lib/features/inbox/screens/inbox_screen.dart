import 'package:flutter/material.dart';

import '../../../ai/ai_fallback.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/models/todo.dart';
import '../../../domain/usecases/add_todo.dart';
import '../../../data/repositories/todo_repository_impl.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final _controller = TextEditingController();
  final _addTodo = AddTodo(TodoRepositoryImpl());
  bool _isSaving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleQuickAdd() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() => _isSaving = true);
    final parsed = AIFallback.parseQuickAdd(input);
    final priority = _mapPriority(parsed['priority'] as String?);
    final todo = Todo(
      id: 'todo_${DateTime.now().millisecondsSinceEpoch}',
      title: parsed['title'] as String? ?? input,
      createdAt: DateTime.now(),
      priority: priority,
      dueDate: parsed['dueDate'] as DateTime?,
      tags: List<String>.from(parsed['tags'] as List? ?? const []),
    );

    await _addTodo(todo);
    if (!mounted) return;
    setState(() => _isSaving = false);
    _controller.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('인박스에 추가했어요'),
        duration: Duration(milliseconds: 1200),
      ),
    );
  }

  Priority _mapPriority(String? value) {
    switch (value) {
      case 'high':
        return Priority.high;
      case 'low':
        return Priority.low;
      default:
        return Priority.medium;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '할 일을 빠르게 추가하세요',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 3,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleQuickAdd(),
              decoration: const InputDecoration(
                hintText: '예) !내일 아침에 보고서 초안 작성 #업무',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSaving ? null : _handleQuickAdd,
                child: _isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('추가'),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '우선순위는 느낌표(!)로 표시돼요.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
