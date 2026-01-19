import 'package:flutter/material.dart';

import '../features/home/screens/home_screen.dart';
import '../features/inbox/screens/inbox_screen.dart';
import '../features/onboarding/screens/onboarding_flow_screen.dart';
import '../features/plan/screens/plan_screen.dart';
import '../features/review/screens/review_screen.dart';
import '../features/settings/screens/settings_screen.dart';

final appRoutes = <String, WidgetBuilder>{
  '/': (context) => const HomeScreen(),
  '/onboarding': (context) => const OnboardingFlowScreen(),
  '/inbox': (context) => const InboxScreen(),
  '/plan': (context) => const PlanScreen(),
  '/review': (context) => const ReviewScreen(),
  '/settings': (context) => const SettingsScreen(),
};
