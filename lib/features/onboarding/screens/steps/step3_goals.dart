import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/onboarding_controller.dart';

class Step3Goals extends ConsumerStatefulWidget {
  const Step3Goals({super.key});

  @override
  ConsumerState<Step3Goals> createState() => _Step3GoalsState();
}

class _Step3GoalsState extends ConsumerState<Step3Goals> {
  final _goalController = TextEditingController();

  void _addGoal() {
    final value = _goalController.text.trim();
    if (value.isEmpty) return;

    final state = ref.read(onboardingControllerProvider);
    if (state.yearGoals.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('목표는 최대 3개까지 가능해요'),
          duration: Duration(milliseconds: 1400),
        ),
      );
      return;
    }

    if (state.yearGoals.contains(value)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이미 추가된 목표예요'),
          duration: Duration(milliseconds: 1400),
        ),
      );
      return;
    }

    ref.read(onboardingControllerProvider.notifier).addYearGoal(value);
    _goalController.clear();
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

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
            '올해 목표를 적어주세요',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.6,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '최대 3개. 목표와 연결된 할 일은 자동으로 더 \'중요\'하게 보여줄 수 있어요.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xA6FFFFFF),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '목표 추가 (Enter)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0x73FFFFFF),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _goalController,
                enabled: state.yearGoals.length < 3,
                onSubmitted: (_) => _addGoal(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xE8FFFFFF),
                ),
                decoration: InputDecoration(
                  hintText: state.yearGoals.length >= 3
                      ? '목표는 최대 3개까지!'
                      : '예) 개발 실력 향상 / 운동 습관 / 저축',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.35),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.06),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.14),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.14),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (state.yearGoals.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: Text(
                '아직 목표가 없어요. 1개만 넣어도 충분해요.',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0x73FFFFFF),
                ),
              ),
            )
          else
            ...state.yearGoals.asMap().entries.map((entry) {
              final index = entry.key;
              final goal = entry.value;
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
                    Expanded(
                      child: Text(
                        goal,
                        style: const TextStyle(
                          fontSize: 13,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          controller.removeYearGoal(index),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0x1FFF6B6B),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '삭제',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xD9FFFFFF),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          const SizedBox(height: 10),
          const Text(
            '팁: 목표는 \'행동으로 이어지는 문장\'이 좋아요. (예: 영어 회화 → 매일 10분 스피킹)',
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
