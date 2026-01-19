import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/onboarding_controller.dart';
import '../widgets/step_header.dart';
import 'steps/step1_life_type.dart';
import 'steps/step2_activity.dart';
import 'steps/step3_goals.dart';
import 'steps/step4_energy.dart';
import 'steps/step5_intents.dart';
import 'steps/step6_summary.dart';

class OnboardingFlowScreen extends ConsumerStatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  ConsumerState<OnboardingFlowScreen> createState() =>
      _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends ConsumerState<OnboardingFlowScreen> {
  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1400),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
        margin: const EdgeInsets.only(bottom: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.6, 1.0],
            colors: [
              Color(0xFF0B1020),
              Color(0xFF0B1020),
              Color(0xFF0B1020),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF7C5CFF),
                                Color(0xFF37D6FF),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.22),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF7C5CFF).withOpacity(0.22),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pulse Todo',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                            ),
                            Text(
                              '나에게 맞춘 투두 온보딩',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0x73FFFFFF),
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        controller.skip();
                        _showToast('기본값으로 시작할게요');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.18),
                          ),
                        ),
                      ),
                      child: const Text(
                        '건너뛰기',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xA6FFFFFF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Progress card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  padding: const EdgeInsets.all(14),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getStepTitle(state.currentStep),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'STEP ${state.currentStep} / 6',
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
                      const SizedBox(height: 10),
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: state.currentStep / 6,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF7C5CFF),
                                  Color(0xFF37D6FF),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: _buildStepContent(state.currentStep),
                ),
              ),

              // Footer buttons
              Padding(
                padding: EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 14,
                  bottom: 14 + MediaQuery.of(context).padding.bottom,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: state.currentStep > 1
                            ? () => controller.previousStep()
                            : null,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.14),
                            ),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.06),
                          disabledForegroundColor: Colors.white.withOpacity(0.45),
                        ),
                        child: const Text(
                          '이전',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: state.canGoNext()
                            ? () {
                                if (state.currentStep < 6) {
                                  controller.nextStep();
                                } else {
                                  controller.complete();
                                  Navigator.of(context).pushReplacementNamed('/');
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          backgroundColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          elevation: 0,
                        ).copyWith(
                          backgroundColor: WidgetStateProperty.resolveWith(
                            (states) {
                              if (states.contains(WidgetState.disabled)) {
                                return Colors.transparent;
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Container(
                          decoration: state.canGoNext()
                              ? const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF7C5CFF),
                                      Color(0xFF37D6FF),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 34,
                                      offset: Offset(0, 16),
                                    ),
                                  ],
                                )
                              : null,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Center(
                            child: Text(
                              state.currentStep == 6 ? '완료' : '다음',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 1:
        return '당신은 어떤 생활 유형인가요?';
      case 2:
        return '주 활동(직장/학교/개인)을 알려주세요';
      case 3:
        return '올해 목표를 1~3개만 적어주세요';
      case 4:
        return '하루 에너지 패턴을 대충이라도 체크해요';
      case 5:
        return '앱을 어떤 방식으로 쓰고 싶나요?';
      case 6:
        return '요약';
      default:
        return '';
    }
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 1:
        return const Step1LifeType();
      case 2:
        return const Step2Activity();
      case 3:
        return const Step3Goals();
      case 4:
        return const Step4Energy();
      case 5:
        return const Step5Intents();
      case 6:
        return const Step6Summary();
      default:
        return const SizedBox();
    }
  }
}
