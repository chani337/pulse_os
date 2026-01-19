import 'package:flutter/material.dart';

import '../../../core/constants/enums.dart';

class EnergyRating extends StatelessWidget {
  final EnergyLevel? selected;
  final ValueChanged<EnergyLevel> onSelected;

  const EnergyRating({
    super.key,
    this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: EnergyLevel.values.map((level) {
        final isSelected = selected == level;
        return GestureDetector(
          onTap: () => onSelected(level),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              level.name.toUpperCase(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
