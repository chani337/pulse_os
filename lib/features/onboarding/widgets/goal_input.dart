import 'package:flutter/material.dart';

class GoalInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const GoalInput({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Your Goal',
        hintText: 'Enter your goal for this year',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      validator: validator,
    );
  }
}
