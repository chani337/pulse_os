import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/onboarding_controller.dart';

class Step5Intents extends ConsumerWidget {
  const Step5Intents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

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
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 45,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '어떻게 쓰고 싶나요?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.6,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '홈 화면과 추천 방식의 기본값을 결정해요.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xA6FFFFFF),
              height: 1.45,
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

              return GestureDetector(
                onTap: () =>
                    controller.toggleIntent(item['key'] as String),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? null
                        : Colors.white.withOpacity(0.06),
                    gradient: isSelected
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0x597C5CFF),
                              Color(0x3837D6FF),
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0x8C7C5CFF)
                          : Colors.white.withOpacity(0.14),
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: const Color(0xFF7C5CFF).withOpacity(0.16),
                              blurRadius: 28,
                              offset: const Offset(0, 12),
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
                                  style: const TextStyle(
                                    fontSize: 13,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item['meta'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0x73FFFFFF),
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
          const Text(
            '선택한 옵션은 나중에 설정에서 바꿀 수 있어요.',
            style: TextStyle(
              fontSize: 12,
              color: Color(0x73FFFFFF),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
