import 'package:hive/hive.dart';

import '../../../../domain/models/user_profile.dart';
import '../../../../domain/models/year_goal.dart';
import '../../../../domain/models/energy_pattern.dart';

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 1;

  @override
  UserProfile read(BinaryReader reader) {
    // Simplified implementation - full implementation would handle nested objects
    return UserProfile(
      id: reader.readString(),
      name: reader.readString(),
      goals: [],
      energyPattern: null,
      createdAt: DateTime.parse(reader.readString()),
      updatedAt: reader.readString().isEmpty ? null : DateTime.parse(reader.readString()),
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeString(obj.updatedAt?.toIso8601String() ?? '');
  }
}
