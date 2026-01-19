import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class YearGoal {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final int year;

  @HiveField(4)
  final DateTime createdAt;

  YearGoal({
    required this.id,
    required this.title,
    this.description,
    required this.year,
    required this.createdAt,
  });

  YearGoal copyWith({
    String? id,
    String? title,
    String? description,
    int? year,
    DateTime? createdAt,
  }) {
    return YearGoal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      year: year ?? this.year,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
