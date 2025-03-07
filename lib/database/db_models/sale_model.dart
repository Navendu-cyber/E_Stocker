import 'package:e_stocker/database/db_models/selling_products.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'sale_model.g.dart';

@HiveType(typeId: 4)
class SaleModel {
  @HiveField(0)
  String saleid;

  @HiveField(1)
  String customerName;

  @HiveField(2)
  String customerPh;

  @HiveField(3)
  String customerAddress;

  @HiveField(4)
  List<SellingProducts> pruduct_quantity;

  @HiveField(5)
  int discout;

  @HiveField(6)
  int totalPrice;

  @HiveField(7)
  DateTime dateTime;

  SaleModel(
      {required this.saleid,
      required this.customerName,
      required this.customerPh,
      required this.customerAddress,
      required this.pruduct_quantity,
      required this.totalPrice,
      required this.discout,
      required this.dateTime});
}
