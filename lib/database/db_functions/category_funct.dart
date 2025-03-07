import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_models/categories.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

String CATEGORY_BOX = 'Category';
final categoryBox = Hive.box<Category>(CATEGORY_BOX);

void addCategory(Category value) {
  var box = categoryBox;
  box.put(value.idCategory, value);
}

void deleteCategory(BuildContext context, String categoryId) {
  bool hasCategory =
      productbox.values.any((product) => product.category == categoryId);

  if (hasCategory) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cannot delete. Category is used by products.'),
        backgroundColor: Colors.blue,
      ),
    );
    return;
  }

  categoryBox.delete(categoryId);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Category deleted successfully!')),
  );
}

void editCAtegory(Category value) {
  categoryBox.put(value.idCategory, value);
}

Category getCatById(String id) {
  return categoryBox.values.firstWhere((value) => value.idCategory == id);
}
