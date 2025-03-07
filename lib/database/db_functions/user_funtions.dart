import 'package:e_stocker/database/db_models/data_user.dart';
import 'package:hive/hive.dart';

const String USER_BOX = "user";
final userBox = Hive.box<User>(USER_BOX);

addUser(User value) {
  var box = Hive.box<User>(USER_BOX);
  box.put("user", value);
}

User getuser() {
  var box = Hive.box<User>(USER_BOX).get('user');

  return box!;
}

editUser(User value) {
  var box = Hive.box<User>(USER_BOX);
  box.put("user", value);
}
