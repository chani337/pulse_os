class QuickAddParser {
  static Map<String, dynamic> parse(String input) {
    final result = <String, dynamic>{
      'title': input,
      'priority': 'medium',
      'dueDate': null,
      'tags': [],
    };

    // Simple parsing logic - can be enhanced
    if (input.contains('!')) {
      result['priority'] = 'high';
    }

    return result;
  }
}
