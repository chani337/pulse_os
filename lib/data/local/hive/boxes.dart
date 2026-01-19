import 'package:hive/hive.dart';

import '../../../core/constants/keys.dart';

class HiveBoxes {
  static Box get todosBox => Hive.box(HiveBoxKeys.todos);
  static Box get userProfileBox => Hive.box(HiveBoxKeys.userProfile);
}
