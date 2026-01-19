import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/keys.dart';
import '../../../data/local/hive/boxes.dart';
import '../../../data/repositories/profile_repository_impl.dart';
import '../../../domain/models/energy_pattern.dart';
import '../../../domain/models/user_profile.dart';
import '../../../domain/models/year_goal.dart';
import '../../../domain/repositories/profile_repository.dart';
import '../../../domain/usecases/save_onboarding_profile.dart';
import '../../../core/constants/enums.dart';
import 'onboarding_state.dart';

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController(this._saveOnboardingProfile)
      : super(const OnboardingState());

  final SaveOnboardingProfile _saveOnboardingProfile;

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

  Future<void> complete() async {
    final now = DateTime.now();
    final goals = state.yearGoals.asMap().entries.map((entry) {
      return YearGoal(
        id: '${now.millisecondsSinceEpoch}-${entry.key}',
        title: entry.value,
        year: now.year,
        createdAt: now,
      );
    }).toList();
    final energyPattern = EnergyPattern(
      hourlyPattern: _mapEnergyToPattern(state.energy),
      createdAt: now,
      updatedAt: now,
    );

    final profile = UserProfile(
      id: 'profile_${now.millisecondsSinceEpoch}',
      name: state.orgName.isNotEmpty ? state.orgName : '사용자',
      goals: goals,
      energyPattern: energyPattern,
      createdAt: now,
      updatedAt: now,
    );

    await _saveOnboardingProfile(profile);
    await HiveBoxes.userProfileBox.put(
      StorageKeys.onboardingCompleted,
      true,
    );
  }

  Map<int, EnergyLevel> _mapEnergyToPattern(Map<String, int> energy) {
    EnergyLevel toLevel(int value) {
      if (value <= 1) return EnergyLevel.low;
      if (value == 2) return EnergyLevel.medium;
      return EnergyLevel.high;
    }

    return {
      8: toLevel(energy['morning'] ?? 3),
      14: toLevel(energy['afternoon'] ?? 3),
      19: toLevel(energy['evening'] ?? 3),
      23: toLevel(energy['night'] ?? 3),
    };
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepositoryImpl(),
);

final saveOnboardingProfileProvider = Provider<SaveOnboardingProfile>(
  (ref) => SaveOnboardingProfile(ref.read(profileRepositoryProvider)),
);

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>(
  (ref) => OnboardingController(ref.read(saveOnboardingProfileProvider)),
);
