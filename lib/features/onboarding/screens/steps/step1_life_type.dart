import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/onboarding_controller.dart';

class Step1LifeType extends ConsumerWidget {
  const Step1LifeType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final items = <_LifeTypeItem>[
      const _LifeTypeItem(
        keyValue: 'worker',
        label: '직장인',
        meta: '평일 루틴 중심',
        icon: Icons.work_outline_rounded,
      ),
      const _LifeTypeItem(
        keyValue: 'student',
        label: '학생',
        meta: '수업/과제 중심',
        icon: Icons.school_outlined,
      ),
      const _LifeTypeItem(
        keyValue: 'freelancer',
        label: '프리랜서',
        meta: '유동 루틴',
        icon: Icons.auto_graph_rounded,
      ),
      const _LifeTypeItem(
        keyValue: 'jobseeker',
        label: '취준생',
        meta: '준비/루틴',
        icon: Icons.search_rounded,
      ),
      const _LifeTypeItem(
        keyValue: 'builder',
        label: '프로젝트 중심',
        meta: '몰입/스프린트',
        icon: Icons.build_circle_outlined,
      ),
      const _LifeTypeItem(
        keyValue: 'other',
        label: '기타',
        meta: '커스텀',
        icon: Icons.tune_rounded,
      ),
    ];

    // "AI 느낌"이 나는 강한 그라데이션/글래스 효과를 줄이고
    // Material3 스타일(부드러운 surface, 얕은 그림자, 자연스러운 강조색)로 정리.
    return Material(
      color: Colors.transparent,
      child: Container(
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
              '당신의 하루 루틴을\n빠르게 맞춰볼게요',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.4,
                height: 1.15,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '생활 유형을 선택하면 추천/정렬/알림의 기본값이 세팅돼요.',
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
                childAspectRatio: 1.55,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = state.lifeType == item.keyValue;

                return _LifeTypeTile(
                  item: item,
                  isSelected: isSelected,
                  scheme: scheme,
                  onTap: () => controller.updateLifeType(item.keyValue),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lock_outline_rounded, size: 16, color: scheme.onSurfaceVariant),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '모든 정보는 로컬에만 저장돼요 (개인용).',
                    style: textTheme.bodySmall?.copyWith(
                      height: 1.4,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LifeTypeTile extends StatelessWidget {
  const _LifeTypeTile({
    required this.item,
    required this.isSelected,
    required this.scheme,
    required this.onTap,
  });

  final _LifeTypeItem item;
  final bool isSelected;
  final ColorScheme scheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final bg = isSelected ? scheme.primaryContainer : scheme.surface;
    final border = isSelected ? scheme.primary : scheme.outlineVariant;
    final titleColor = isSelected ? scheme.onPrimaryContainer : scheme.onSurface;
    final metaColor = isSelected ? scheme.onPrimaryContainer.withOpacity(0.72) : scheme.onSurfaceVariant;
    final iconColor = isSelected ? scheme.primary : scheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: border),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: scheme.primary.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected ? scheme.primary.withOpacity(0.12) : scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2,
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.meta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall?.copyWith(
                        color: metaColor,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              AnimatedOpacity(
                opacity: isSelected ? 1 : 0,
                duration: const Duration(milliseconds: 120),
                child: Icon(Icons.check_circle_rounded, color: scheme.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LifeTypeItem {
  const _LifeTypeItem({
    required this.keyValue,
    required this.label,
    required this.meta,
    required this.icon,
  });

  final String keyValue;
  final String label;
  final String meta;
  final IconData icon;
}
