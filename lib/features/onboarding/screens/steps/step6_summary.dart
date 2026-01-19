import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/onboarding_controller.dart';

class Step6Summary extends ConsumerWidget {
  const Step6Summary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final lifeMap = {
      'worker': '직장인',
      'student': '학생',
      'freelancer': '프리랜서',
      'jobseeker': '취준생',
      'builder': '프로젝트 중심',
      'other': '기타',
    };

    final intentMap = {
      'focus_3': '하루 3~5개 집중',
      'overview': '전체 한눈에',
      'anti_procrast': '미루기 개선',
      'insights': '패턴 분석',
      'quick_add': '빠른 입력',
      'gentle': '부드러운 알림',
    };

    final blocksMap = {
      'morning': '오전',
      'afternoon': '오후',
      'evening': '저녁',
    };

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
            '완성! 이제 당신에게 맞춰질 거예요',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              height: 1.15,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '이 설정으로 \'지금 가능한 일\' 중심 추천이 시작돼요.',
            style: textTheme.bodySmall?.copyWith(
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: scheme.outlineVariant,
              ),
            ),
            child: Column(
              children: [
                _buildSummaryRow(
                  '생활 유형',
                  lifeMap[state.lifeType] ?? '-',
                  scheme: scheme,
                ),
                Divider(
                  height: 1,
                  color: scheme.outlineVariant,
                ),
                _buildSummaryRow(
                  '주 활동',
                  state.orgName.isEmpty ? '입력 없음' : state.orgName,
                  scheme: scheme,
                ),
                Divider(
                  height: 1,
                  color: scheme.outlineVariant,
                ),
                _buildSummaryRow(
                  '활동 시간대',
                  state.activeBlocks
                      .map((k) => blocksMap[k] ?? k)
                      .join(', '),
                  scheme: scheme,
                ),
                Divider(
                  height: 1,
                  color: scheme.outlineVariant,
                ),
                _buildSummaryRow(
                  '올해 목표',
                  state.yearGoals.isEmpty
                      ? '-'
                      : state.yearGoals.join('\n'),
                  isMultiline: state.yearGoals.length > 1,
                  scheme: scheme,
                ),
                Divider(
                  height: 1,
                  color: scheme.outlineVariant,
                ),
                _buildSummaryRow(
                  '에너지(아침/오후/저녁/밤)',
                  '${state.energy['morning']} / ${state.energy['afternoon']} / ${state.energy['evening']} / ${state.energy['night']}',
                  scheme: scheme,
                ),
                Divider(
                  height: 1,
                  color: scheme.outlineVariant,
                ),
                _buildSummaryRow(
                  '사용 방식',
                  state.intents.isEmpty
                      ? '-'
                      : state.intents
                          .map((k) => intentMap[k] ?? k)
                          .join('\n'),
                  isMultiline: state.intents.length > 1,
                  scheme: scheme,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '다음 단계: 홈 화면에서 "지금 몇 분 가능해?" + "에너지 어때?"를 받아서 가능한 일만 보여주면 MVP 완성!',
            style: textTheme.bodySmall?.copyWith(
              height: 1.4,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String key,
    String value, {
    bool isMultiline = false,
    required ColorScheme scheme,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment:
            isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              key,
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
