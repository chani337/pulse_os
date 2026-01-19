import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/keys.dart';
import '../data/local/hive/boxes.dart';
import '../features/home/screens/home_screen.dart';
import '../features/onboarding/screens/onboarding_flow_screen.dart';
import 'routes.dart';
import 'theme.dart';

class PulseApp extends ConsumerWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Pulse OS',
      theme: appTheme,
      routes: appRoutes,
      home: const _OnboardingGate(),
    );
  }
}

class _OnboardingGate extends StatelessWidget {
  const _OnboardingGate();

  Future<bool> _loadOnboardingCompleted() async {
    final box = HiveBoxes.userProfileBox;
    return box.get(StorageKeys.onboardingCompleted, defaultValue: false) as bool;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _loadOnboardingCompleted(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return snapshot.data == true
            ? const HomeScreen()
            : const OnboardingFlowScreen();
      },
    );
  }
}
