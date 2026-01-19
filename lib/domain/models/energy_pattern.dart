import 'package:hive/hive.dart';

import '../../core/constants/enums.dart';

@HiveType(typeId: 3)
class EnergyPattern {
  @HiveField(0)
  final Map<int, EnergyLevel> hourlyPattern;

  @HiveField(1)
  final DateTime createdAt;

  @HiveField(2)
  final DateTime? updatedAt;

  EnergyPattern({
    required this.hourlyPattern,
    required this.createdAt,
    this.updatedAt,
  });

  EnergyPattern copyWith({
    Map<int, EnergyLevel>? hourlyPattern,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EnergyPattern(
      hourlyPattern: hourlyPattern ?? this.hourlyPattern,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
