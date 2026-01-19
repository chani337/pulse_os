import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      initialRoute: '/onboarding', // 온보딩 화면을 먼저 표시
    );
  }
}
