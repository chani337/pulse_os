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

    final blocks = [
      {'key': 'morning', 'label': '오전 (9~12)'},
      {'key': 'afternoon', 'label': '오후 (13~18)'},
      {'key': 'evening', 'label': '저녁 (18~22)'},
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
            '어디에서 대부분의 시간을 보내나요?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.6,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '회사/학교 이름은 대충 적어도 돼요. 중요한 건 \'시간대\'예요.',
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
                '직장/학교/주 활동 이름 (선택)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0x73FFFFFF),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _orgController,
                onChanged: (value) =>
                    controller.updateOrgName(value),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xE8FFFFFF),
                ),
                decoration: InputDecoration(
                  hintText: '예) 네이버, OO중학교, 개인 개발',
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
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '주요 활동 시간대 (복수 선택)',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0x73FFFFFF),
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: blocks.map((block) {
                  final isSelected =
                      state.activeBlocks.contains(block['key']);

                  return GestureDetector(
                    onTap: () =>
                        controller.toggleActiveBlock(block['key'] as String),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? null
                            : Colors.white.withOpacity(0.06),
                        gradient: isSelected
                            ? const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0x382EE59D),
                                  Color(0x2437D6FF),
                                ],
                              )
                            : null,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0x592EE59D)
                              : Colors.white.withOpacity(0.14),
                        ),
                      ),
                      child: Text(
                        block['label'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? const Color(0xE8FFFFFF)
                              : const Color(0xA6FFFFFF),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '이 설정은 \'추천 제외 시간(업무시간)\'을 만들기 위해 사용돼요.',
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
