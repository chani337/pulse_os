import 'package:hive/hive.dart';

import '../../../../domain/models/todo.dart';
import '../../../../core/constants/enums.dart';

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final descriptionStr = reader.readString();
    final description = descriptionStr.isEmpty ? null : descriptionStr;
    final status = TodoStatus.values[reader.readByte()];
    final priority = Priority.values[reader.readByte()];
    final createdAt = DateTime.parse(reader.readString());
    final dueDateStr = reader.readString();
    final dueDate = dueDateStr.isEmpty ? null : DateTime.parse(dueDateStr);
    final completedAtStr = reader.readString();
    final completedAt = completedAtStr.isEmpty ? null : DateTime.parse(completedAtStr);
    final tags = List<String>.from(reader.read() as List);
    
    return Todo(
      id: id,
      title: title,
      description: description,
      status: status,
      priority: priority,
      createdAt: createdAt,
      dueDate: dueDate,
      completedAt: completedAt,
      tags: tags,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description ?? '');
    writer.writeByte(obj.status.index);
    writer.writeByte(obj.priority.index);
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeString(obj.dueDate?.toIso8601String() ?? '');
    writer.writeString(obj.completedAt?.toIso8601String() ?? '');
    writer.write(obj.tags);
  }
}
