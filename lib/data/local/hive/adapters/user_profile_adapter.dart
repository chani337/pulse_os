import 'package:hive/hive.dart';

import '../../../../domain/models/user_profile.dart';
import '../../../../domain/models/year_goal.dart';
import '../../../../domain/models/energy_pattern.dart';

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 1;

  @override
  UserProfile read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final goals = List<YearGoal>.from(reader.read() as List);
    final energyPattern = reader.read() as EnergyPattern?;
    final createdAt = DateTime.parse(reader.readString());
    final updatedAtStr = reader.readString();
    final updatedAt =
        updatedAtStr.isEmpty ? null : DateTime.parse(updatedAtStr);
    return UserProfile(
      id: id,
      name: name,
      goals: goals,
      energyPattern: energyPattern,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.write(obj.goals);
    writer.write(obj.energyPattern);
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeString(obj.updatedAt?.toIso8601String() ?? '');
  }
}
