import 'package:flutter/material.dart';

class NowContextBar extends StatelessWidget {
  final String contextText;
  final DateTime? timestamp;

  const NowContextBar({
    super.key,
    required this.contextText,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              contextText,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
