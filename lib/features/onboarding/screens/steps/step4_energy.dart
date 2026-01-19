import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/onboarding_controller.dart';

class Step4Energy extends ConsumerWidget {
  const Step4Energy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    final times = [
      {'key': 'morning', 'label': '아침'},
      {'key': 'afternoon', 'label': '점심/오후'},
      {'key': 'evening', 'label': '저녁'},
      {'key': 'night', 'label': '밤'},
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
            '에너지는 언제 높나요?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.6,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '대충 체크해도 충분해요. 힘든 일은 에너지 높은 시간대에 추천할게요.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xA6FFFFFF),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          ...times.map((time) {
            final currentValue = state.energy[time['key']] ?? 3;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time['label'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xA6FFFFFF),
                    ),
                  ),
                  Row(
                    children: List.generate(4, (index) {
                      final value = index + 1;
                      final isSelected = value <= currentValue;

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
                            color: isSelected
                                ? null
                                : Colors.white.withOpacity(0.06),
                            gradient: isSelected
                                ? const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0x38FFCC66),
                                      Color(0x387C5CFF),
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0x59FFCC66)
                                  : Colors.white.withOpacity(0.16),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '✦',
                              style: TextStyle(
                                fontSize: 14,
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
          const Text(
            '별은 1~4로 설정돼요. (1=낮음, 4=높음)',
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
