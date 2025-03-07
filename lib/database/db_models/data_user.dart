import 'package:hive/hive.dart';
part 'data_user.g.dart';

@HiveType(typeId: 0)

class User{
  User({required  this.name,required this.shopname,required this.phonenumber, required this.email,required this.filepaath});
  @HiveField(0)
  String name;

  @HiveField(1)
  String shopname;

    @HiveField(2)
  String phonenumber;

    @HiveField(3)
  String email;

      @HiveField(4)
  String filepaath;

}