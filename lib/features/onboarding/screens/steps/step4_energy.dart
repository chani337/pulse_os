import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/onboarding_controller.dart';

class Step4Energy extends ConsumerWidget {
  const Step4Energy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final times = [
      {'key': 'morning', 'label': '아침'},
      {'key': 'afternoon', 'label': '점심/오후'},
      {'key': 'evening', 'label': '저녁'},
      {'key': 'night', 'label': '밤'},
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '에너지는 언제 높나요?',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              height: 1.15,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '대충 체크해도 충분해요. 힘든 일은 에너지 높은 시간대에 추천할게요.',
            style: textTheme.bodySmall?.copyWith(
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          ...times.map((time) {
            final currentValue = state.energy[time['key']] ?? 3;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: scheme.outlineVariant,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time['label'] as String,
                    style: textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  Row(
                    children: List.generate(4, (index) {
                      final value = index + 1;
                      final isSelected = value <= currentValue;
                      final bgColor = isSelected
                          ? scheme.primaryContainer
                          : scheme.surfaceContainerHighest;
                      final borderColor = isSelected
                          ? scheme.primary
                          : scheme.outlineVariant;
                      final starColor = isSelected
                          ? scheme.onPrimaryContainer
                          : scheme.onSurfaceVariant;

                      return GestureDetector(
                        onTap: () => controller.updateEnergy(
                          time['key'] as String,
                          value,
                        ),
                        child: Container(
                          width: 26,
                          height: 26,
                          margin: const EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: borderColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '✦',
                              style: TextStyle(
                                fontSize: 14,
                                color: starColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 10),
          Text(
            '별은 1~4로 설정돼요. (1=낮음, 4=높음)',
            style: textTheme.bodySmall?.copyWith(
              height: 1.4,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
