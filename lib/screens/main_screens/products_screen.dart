import 'package:e_stocker/common%20widgets/customtextfield.dart';
import 'package:e_stocker/common%20widgets/product_card.dart';
import 'package:e_stocker/database/db_functions/category_funct.dart';
import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_models/product_model.dart';
import 'package:e_stocker/notification/notification_class.dart';
import 'package:e_stocker/screens/add_screens/product_add.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductsScreen extends StatefulWidget {
  final bool isInstock;

  ProductsScreen({super.key, required this.isInstock});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final NotificationClass notificationService = NotificationClass();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTexfield(
              controller: _searchController,
              hintText: 'Search Product',
              floating: FloatingLabelBehavior.always,
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<Box<Product>>(
              valueListenable: productbox.listenable(),
              builder: (context, Box<Product> box, child) {
                final allProducts = box.values.toList();
                final query = _searchController.text.trim().toLowerCase();
                final filteredProducts = allProducts.where((product) {
                  final isStockMatch = widget.isInstock
                      ? product.stockcount > 0
                      : product.stockcount == 0;
                  final isSearchMatch = query.isEmpty ||
                      product.productName.toLowerCase().contains(query);
                  return isStockMatch && isSearchMatch;
                }).toList();

                if (filteredProducts.isEmpty) {
                  return Center(
                    child: Text(
                      widget.isInstock
                          ? "No In Stock Products"
                          : "No Out of Stock Products",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 230,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    var cat = getCatById(product.category);

                    return SizedBox(
                      height: 270,
                      child: ProductCard(
                        productmodel: product,
                        sellprice: product.sellprice.toString(),
                        category: cat.categoryname,
                        quantity: product.stockcount,
                        brandname: product.brand,
                        productname: product.productName,
                        image: product.imageProduct.toString(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return AddProduct();
          }));
        },
        label: Text('Add Product'),
        icon: Icon(Icons.add_shopping_cart_rounded),
      ),
    );
  }
}
