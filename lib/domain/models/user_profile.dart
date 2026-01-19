import 'package:hive/hive.dart';

import 'energy_pattern.dart';
import 'year_goal.dart';

@HiveType(typeId: 1)
class UserProfile {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<YearGoal> goals;

  @HiveField(3)
  final EnergyPattern? energyPattern;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime? updatedAt;

  UserProfile({
    required this.id,
    required this.name,
    this.goals = const [],
    this.energyPattern,
    required this.createdAt,
    this.updatedAt,
  });

  UserProfile copyWith({
    String? id,
    String? name,
    List<YearGoal>? goals,
    EnergyPattern? energyPattern,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      goals: goals ?? this.goals,
      energyPattern: energyPattern ?? this.energyPattern,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
