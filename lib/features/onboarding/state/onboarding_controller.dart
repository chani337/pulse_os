import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'onboarding_state.dart';

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController() : super(const OnboardingState());

  void updateLifeType(String? lifeType) {
    state = state.copyWith(lifeType: lifeType);
  }

  void updateOrgName(String orgName) {
    state = state.copyWith(orgName: orgName);
  }

  void toggleActiveBlock(String block) {
    final newBlocks = Set<String>.from(state.activeBlocks);
    if (newBlocks.contains(block)) {
      newBlocks.remove(block);
    } else {
      newBlocks.add(block);
    }
    state = state.copyWith(activeBlocks: newBlocks);
  }

  void addYearGoal(String goal) {
    if (state.yearGoals.length >= 3) return;
    if (state.yearGoals.contains(goal)) return;
    final newGoals = List<String>.from(state.yearGoals)..add(goal);
    state = state.copyWith(yearGoals: newGoals);
  }

  void removeYearGoal(int index) {
    final newGoals = List<String>.from(state.yearGoals)..removeAt(index);
    state = state.copyWith(yearGoals: newGoals);
  }

  void updateEnergy(String time, int value) {
    final newEnergy = Map<String, int>.from(state.energy);
    newEnergy[time] = value;
    state = state.copyWith(energy: newEnergy);
  }

  void toggleIntent(String intent) {
    final newIntents = Set<String>.from(state.intents);
    if (newIntents.contains(intent)) {
      newIntents.remove(intent);
    } else {
      newIntents.add(intent);
    }
    state = state.copyWith(intents: newIntents);
  }

  void nextStep() {
    if (state.canGoNext() && state.currentStep < 6) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void skip() {
    // 기본값으로 빠르게 시작
    state = OnboardingState(
      currentStep: 6,
      lifeType: state.lifeType ?? 'builder',
      orgName: state.orgName,
      activeBlocks: state.activeBlocks.isEmpty
          ? {'afternoon'}
          : state.activeBlocks,
      yearGoals: state.yearGoals.isEmpty
          ? ['올해 루틴 만들기']
          : state.yearGoals,
      energy: state.energy,
      intents: state.intents.isEmpty ? {'focus_3'} : state.intents,
    );
  }

  void complete() {
    // 온보딩 완료 처리
    // TODO: 프로필 저장 및 홈 화면으로 이동
  }
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>(
  (ref) => OnboardingController(),
);
