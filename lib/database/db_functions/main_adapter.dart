import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_functions/sale_func.dart';
import 'package:e_stocker/database/db_models/categories.dart';
import 'package:e_stocker/database/db_models/data_user.dart';
import 'package:e_stocker/database/db_models/product_model.dart';
import 'package:e_stocker/database/db_models/sale_model.dart';
import 'package:e_stocker/database/db_models/selling_products.dart';
import 'package:e_stocker/database/db_models/theme_switching.dart';
import 'package:e_stocker/database/db_functions/category_funct.dart';
import 'package:e_stocker/database/db_functions/user_funtions.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> hiveinitialisation() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(SellingProductsAdapter());
  Hive.registerAdapter(SaleModelAdapter());

  await Hive.openBox<User>(USER_BOX);
  await Hive.openBox<Category>(CATEGORY_BOX);
  await Hive.openBox<Product>(PRODUCT_BOX);
  await Hive.openBox<SellingProducts>(SELLING_BOX);
  await Hive.openBox<SaleModel>(SALE_BOX);
  await ThemeSwitching.loadTheme();
}
