import '../../../domain/models/user_profile.dart';
import '../../../domain/repositories/profile_repository.dart';
import '../local/hive/boxes.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  static const String _profileKey = 'user_profile';

  @override
  Future<UserProfile?> getProfile() async {
    final box = HiveBoxes.userProfileBox;
    return box.get(_profileKey) as UserProfile?;
  }

  @override
  Future<void> saveProfile(UserProfile profile) async {
    final box = HiveBoxes.userProfileBox;
    await box.put(_profileKey, profile);
  }

  @override
  Future<void> deleteProfile() async {
    final box = HiveBoxes.userProfileBox;
    await box.delete(_profileKey);
  }
}
