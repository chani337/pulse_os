import 'package:hive/hive.dart';

import '../../../../core/constants/enums.dart';
import '../../../../domain/models/energy_pattern.dart';

class EnergyPatternAdapter extends TypeAdapter<EnergyPattern> {
  @override
  final int typeId = 3;

  @override
  EnergyPattern read(BinaryReader reader) {
    final rawMap = Map<int, int>.from(reader.read() as Map);
    final hourlyPattern = rawMap.map(
      (key, value) => MapEntry(key, EnergyLevel.values[value]),
    );
    final createdAt = DateTime.parse(reader.readString());
    final updatedAtStr = reader.readString();
    final updatedAt =
        updatedAtStr.isEmpty ? null : DateTime.parse(updatedAtStr);

    return EnergyPattern(
      hourlyPattern: hourlyPattern,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  void write(BinaryWriter writer, EnergyPattern obj) {
    final rawMap = obj.hourlyPattern.map(
      (key, value) => MapEntry(key, value.index),
    );
    writer.write(rawMap);
    writer.writeString(obj.createdAt.toIso8601String());
    writer.writeString(obj.updatedAt?.toIso8601String() ?? '');
  }
}
