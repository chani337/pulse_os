import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/keys.dart';
import 'adapters/todo_adapter.dart';
import 'adapters/user_profile_adapter.dart';

Future<void> initializeHive() async {
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(UserProfileAdapter());
  
  await openBoxes();
}

Future<void> openBoxes() async {
  await Hive.openBox(HiveBoxKeys.todos);
  await Hive.openBox(HiveBoxKeys.userProfile);
}
