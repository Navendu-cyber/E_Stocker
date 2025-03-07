import 'package:hive_flutter/hive_flutter.dart';

part 'selling_products.g.dart';

@HiveType(typeId: 5)
class SellingProducts {
  @HiveField(0)
  String productId;

  @HiveField(1)
  int productQuantity;

  SellingProducts({required this.productId, required this.productQuantity});
}
