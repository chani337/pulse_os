import 'package:hive/hive.dart';

import '../../core/constants/enums.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final TodoStatus status;

  @HiveField(4)
  final Priority priority;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final DateTime? dueDate;

  @HiveField(7)
  final DateTime? completedAt;

  @HiveField(8)
  final List<String> tags;

  Todo({
    required this.id,
    required this.title,
    this.description,
    this.status = TodoStatus.pending,
    this.priority = Priority.medium,
    required this.createdAt,
    this.dueDate,
    this.completedAt,
    this.tags = const [],
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    TodoStatus? status,
    Priority? priority,
    DateTime? createdAt,
    DateTime? dueDate,
    DateTime? completedAt,
    List<String>? tags,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      completedAt: completedAt ?? this.completedAt,
      tags: tags ?? this.tags,
    );
  }
}
