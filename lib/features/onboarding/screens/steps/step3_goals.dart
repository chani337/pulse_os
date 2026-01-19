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
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
            '올해 목표를 적어주세요',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              height: 1.15,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '최대 3개. 목표와 연결된 할 일은 자동으로 더 \'중요\'하게 보여줄 수 있어요.',
            style: textTheme.bodySmall?.copyWith(
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '목표 추가 (Enter)',
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _goalController,
                enabled: state.yearGoals.length < 3,
                onSubmitted: (_) => _addGoal(),
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: state.yearGoals.length >= 3
                      ? '목표는 최대 3개까지!'
                      : '예) 개발 실력 향상 / 운동 습관 / 저축',
                  hintStyle: textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: scheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: scheme.outlineVariant,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: scheme.outlineVariant,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: scheme.primary,
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              child: Text(
                '아직 목표가 없어요. 1개만 넣어도 충분해요.',
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
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
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: scheme.outlineVariant,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        goal,
                        style: textTheme.bodyMedium?.copyWith(
                          letterSpacing: -0.2,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          controller.removeYearGoal(index),
                      style: TextButton.styleFrom(
                        backgroundColor: scheme.errorContainer,
                        foregroundColor: scheme.onErrorContainer,
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
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          const SizedBox(height: 10),
          Text(
            '팁: 목표는 \'행동으로 이어지는 문장\'이 좋아요. (예: 영어 회화 → 매일 10분 스피킹)',
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
