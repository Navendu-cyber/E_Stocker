import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 3)
class Product {
  Product(
      {required this.productid,
      required this.productName,
      required this.brand,
      required this.color,
      required this.stockcount,
      required this.buyprice,
      required this.sellprice,
      required this.imageProduct,
      required this.category,
      this.barcodeId});
  @HiveField(0)
  String productid;

  @HiveField(1)
  String productName;

  @HiveField(2)
  String brand;

  @HiveField(3)
  String color;

  @HiveField(4)
  int stockcount;

  @HiveField(5)
  int buyprice;

  @HiveField(6)
  int sellprice;

  @HiveField(7)
  String imageProduct;

  @HiveField(8)
  String category;

  @HiveField(9)
  String? barcodeId;
}
