import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_models/sale_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

String SELLING_BOX = 'sellingProducts';
String SALE_BOX = 'sales';
final saleBox = Hive.box<SaleModel>(SALE_BOX);

addSale(SaleModel sale) {
  saleBox.put(sale.saleid, sale);

  for (var item in sale.pruduct_quantity) {
    final product = productbox.get(item.productId);

    if (product != null) {
      product.stockcount -= item.productQuantity;

      if (product.stockcount < 0) {
        product.stockcount = 0;
      }

      productbox.put(item.productId, product);
    }
  }
  productnotifier.notifyListeners();
}

deleteSale(String saleKey) {
  try {
    if (saleBox.containsKey(saleKey)) {
      saleBox.delete(saleKey);
      print("Sale deleted successfully!");
    } else {
      print("Sale not found!");
    }
  } catch (e) {
    print("Error deleting sale: $e");
  }
}
