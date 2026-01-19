import '../engines/rules/quick_add_parser.dart';
import '../engines/templates/breakdown_templates.dart';
import '../engines/rules/review_insights_rules.dart';
import '../domain/models/todo.dart';

// Fallback implementations when AI is not available
class AIFallback {
  static Map<String, dynamic> parseQuickAdd(String input) {
    return QuickAddParser.parse(input);
  }

  static List<String> breakdownGoal(String goal) {
    return BreakdownTemplates.getBreakdownSteps(goal);
  }

  static Map<String, dynamic> generateInsights(List<Todo> todos) {
    return ReviewInsightsRules.generateInsights(todos);
  }
}
