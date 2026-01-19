import 'package:flutter/material.dart';

import '../../../domain/models/todo.dart';
import '../../../core/constants/enums.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;

  const TodoCard({
    super.key,
    required this.todo,
    this.onTap,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(todo.title),
        subtitle: todo.description != null ? Text(todo.description!) : null,
        trailing: todo.status == TodoStatus.pending
            ? IconButton(
                icon: const Icon(Icons.check_circle_outline),
                onPressed: onComplete,
              )
            : const Icon(Icons.check_circle, color: Colors.green),
        onTap: onTap,
      ),
    );
  }
}
