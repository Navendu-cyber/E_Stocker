import 'package:e_stocker/screens/main_screens/products_screen.dart';
import 'package:flutter/material.dart';

class ProductScreenOut extends StatefulWidget {
  const ProductScreenOut({super.key});

  @override
  State<ProductScreenOut> createState() => _ProductScreenOutState();
}

class _ProductScreenOutState extends State<ProductScreenOut> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(78),
            child: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.shopping_cart_checkout_outlined),
                    text: 'In Stock',
                  ),
                  Tab(
                    icon: Icon(Icons.production_quantity_limits),
                    text: 'Out of Stock',
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(children: [
            ProductsScreen(isInstock: true),
            ProductsScreen(isInstock: false),
          ]),
        ));
  }
}
