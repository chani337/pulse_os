class OnboardingState {
  final int currentStep;
  final String? lifeType; // worker, student, freelancer, jobseeker, builder, other
  final String orgName;
  final Set<String> activeBlocks; // morning, afternoon, evening
  final List<String> yearGoals; // 최대 3개
  final Map<String, int> energy; // morning, afternoon, evening, night (1-4)
  final Set<String> intents; // focus_3, overview, anti_procrast, insights, quick_add, gentle

  const OnboardingState({
    this.currentStep = 1,
    this.lifeType,
    this.orgName = '',
    this.activeBlocks = const {},
    this.yearGoals = const [],
    this.energy = const {
      'morning': 3,
      'afternoon': 2,
      'evening': 4,
      'night': 1,
    },
    this.intents = const {},
  });

  OnboardingState copyWith({
    int? currentStep,
    String? lifeType,
    String? orgName,
    Set<String>? activeBlocks,
    List<String>? yearGoals,
    Map<String, int>? energy,
    Set<String>? intents,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      lifeType: lifeType ?? this.lifeType,
      orgName: orgName ?? this.orgName,
      activeBlocks: activeBlocks ?? this.activeBlocks,
      yearGoals: yearGoals ?? this.yearGoals,
      energy: energy ?? this.energy,
      intents: intents ?? this.intents,
    );
  }

  bool canGoNext() {
    switch (currentStep) {
      case 1:
        return lifeType != null;
      case 2:
        return activeBlocks.isNotEmpty;
      case 3:
        return yearGoals.isNotEmpty;
      case 4:
        return true;
      case 5:
        return intents.isNotEmpty;
      case 6:
        return true;
      default:
        return false;
    }
  }
}
