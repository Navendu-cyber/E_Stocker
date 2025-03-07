import 'package:hive/hive.dart';

part 'categories.g.dart';

@HiveType(typeId: 1)
class Category {
  Category({required this.categoryname,required this.idCategory});
  @HiveField(0)
  String idCategory;
  @HiveField(1)
  String categoryname;
}
