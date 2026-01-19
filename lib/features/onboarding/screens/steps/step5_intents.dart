import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/onboarding_controller.dart';

class Step5Intents extends ConsumerWidget {
  const Step5Intents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final items = [
      {'key': 'focus_3', 'label': '하루 3~5개만', 'meta': '압도감 없이'},
      {'key': 'overview', 'label': '전체를 한눈에', 'meta': '큰 그림'},
      {'key': 'anti_procrast', 'label': '미루기 개선', 'meta': '패턴 교정'},
      {'key': 'insights', 'label': '나의 패턴 분석', 'meta': '회고 자동화'},
      {'key': 'quick_add', 'label': '빠른 입력 최우선', 'meta': '1줄로 끝'},
      {'key': 'gentle', 'label': '부드러운 알림', 'meta': '압박 없이'},
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
            '어떻게 쓰고 싶나요?',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              height: 1.15,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '홈 화면과 추천 방식의 기본값을 결정해요.',
            style: textTheme.bodySmall?.copyWith(
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isSelected = state.intents.contains(item['key']);
              final bgColor = isSelected
                  ? scheme.primaryContainer
                  : scheme.surface;
              final borderColor = isSelected
                  ? scheme.primary
                  : scheme.outlineVariant;
              final titleColor = isSelected
                  ? scheme.onPrimaryContainer
                  : scheme.onSurface;
              final metaColor = isSelected
                  ? scheme.onPrimaryContainer.withOpacity(0.75)
                  : scheme.onSurfaceVariant;

              return GestureDetector(
                onTap: () =>
                    controller.toggleIntent(item['key'] as String),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: borderColor,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: scheme.primary.withOpacity(0.12),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['label'] as String,
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontSize: 13,
                                    letterSpacing: -0.2,
                                    color: titleColor,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item['meta'] as String,
                                  style: textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    color: metaColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Text(
            '선택한 옵션은 나중에 설정에서 바꿀 수 있어요.',
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
