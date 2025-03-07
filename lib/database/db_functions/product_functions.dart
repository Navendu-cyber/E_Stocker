import 'dart:developer';

import 'package:e_stocker/database/db_models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<Product>> productnotifier = ValueNotifier([]);
String PRODUCT_BOX = 'Product';
final productbox = Hive.box<Product>(PRODUCT_BOX);

addproduct(Product value) {
  productbox.put(value.productid, value);
  getAllProducts();
}

void getbox() {
  if (productbox.isEmpty) {
    log('Empty');
  }
}

getAllProducts() {
  productnotifier.value.clear();
  productnotifier.value.addAll(productbox.values);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    productnotifier.notifyListeners();
  });
}

deleteProduct(value) {
  productbox.delete(value);
  getAllProducts();
}
