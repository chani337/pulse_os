import '../models/user_profile.dart';
import '../repositories/profile_repository.dart';

class SaveOnboardingProfile {
  final ProfileRepository repository;

  SaveOnboardingProfile(this.repository);

  Future<void> call(UserProfile profile) async {
    await repository.saveProfile(profile);
  }
}
