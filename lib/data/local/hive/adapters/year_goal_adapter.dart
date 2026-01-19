import 'package:hive/hive.dart';

import '../../../../domain/models/year_goal.dart';

class YearGoalAdapter extends TypeAdapter<YearGoal> {
  @override
  final int typeId = 2;

  @override
  YearGoal read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final descriptionStr = reader.readString();
    final description = descriptionStr.isEmpty ? null : descriptionStr;
    final year = reader.readInt();
    final createdAt = DateTime.parse(reader.readString());

    return YearGoal(
      id: id,
      title: title,
      description: description,
      year: year,
      createdAt: createdAt,
    );
  }

  @override
  void write(BinaryWriter writer, YearGoal obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description ?? '');
    writer.writeInt(obj.year);
    writer.writeString(obj.createdAt.toIso8601String());
  }
}
