import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/onboarding_controller.dart';

class Step2Activity extends ConsumerStatefulWidget {
  const Step2Activity({super.key});

  @override
  ConsumerState<Step2Activity> createState() => _Step2ActivityState();
}

class _Step2ActivityState extends ConsumerState<Step2Activity> {
  final _orgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = ref.read(onboardingControllerProvider);
    _orgController.text = state.orgName;
  }

  @override
  void dispose() {
    _orgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final blocks = [
      {'key': 'morning', 'label': '오전 (9~12)'},
      {'key': 'afternoon', 'label': '오후 (13~18)'},
      {'key': 'evening', 'label': '저녁 (18~22)'},
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
            '어디에서 대부분의 시간을 보내나요?',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              height: 1.15,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '회사/학교 이름은 대충 적어도 돼요. 중요한 건 \'시간대\'예요.',
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
                '직장/학교/주 활동 이름 (선택)',
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _orgController,
                onChanged: (value) =>
                    controller.updateOrgName(value),
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: '예) 네이버, OO중학교, 개인 개발',
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
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '주요 활동 시간대 (복수 선택)',
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: blocks.map((block) {
                  final isSelected =
                      state.activeBlocks.contains(block['key']);
                  final bgColor = isSelected
                      ? scheme.primaryContainer
                      : scheme.surface;
                  final borderColor = isSelected
                      ? scheme.primary
                      : scheme.outlineVariant;
                  final textColor = isSelected
                      ? scheme.onPrimaryContainer
                      : scheme.onSurfaceVariant;

                  return GestureDetector(
                    onTap: () =>
                        controller.toggleActiveBlock(block['key'] as String),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      child: Text(
                        block['label'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '이 설정은 \'추천 제외 시간(업무시간)\'을 만들기 위해 사용돼요.',
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
