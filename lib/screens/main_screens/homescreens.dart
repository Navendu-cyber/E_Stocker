import 'dart:developer';

import 'package:e_stocker/common%20widgets/customtextfield.dart';
import 'package:e_stocker/common%20widgets/product_card.dart';
import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_functions/user_funtions.dart';
import 'package:e_stocker/database/db_models/data_user.dart';
import 'package:e_stocker/database/db_models/product_model.dart';
import 'package:e_stocker/notification/notification_listScreen.dart';
import 'package:e_stocker/screens/main_screens/sub_screens.dart/ordersummary.dart';
import 'package:flutter/material.dart';

class Homescreens extends StatefulWidget {
  const Homescreens({super.key});

  @override
  State<Homescreens> createState() => _HomescreensState();
}

class _HomescreensState extends State<Homescreens> {
  User? user;
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    getuser();
    log("initcaleed!");
    getAllProducts();
    fetchUser();
    searchcontroller.addListener(filterdProduct);
    // TODO: implement initState
    super.initState();
  }

  void fetchUser() async {
    user = await getuser();
    setState(() {});
  }

  List<Product> filterdProductList = [];
  void filterdProduct() {
    setState(() {
      filterdProductList = productnotifier.value
          .where((value) => value.productName
              .toLowerCase()
              .contains(searchcontroller.text.trim().toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    searchcontroller.removeListener(filterdProduct);
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user == null ? 'Loading...' : 'Hi ${user!.name},'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.notifications, size: 28),
                if (notificationService.notifications.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${notificationService.notifications.length}',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationListScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTexfield(
                controller: searchcontroller,
                hintText: 'Search',
                floating: FloatingLabelBehavior.auto),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Product>>(
              valueListenable: productnotifier,
              builder: (context, value, child) {
                var dispay = (searchcontroller.text.isEmpty)
                    ? value
                    : filterdProductList;
                return value.isEmpty
                    ? Center(
                        child: Text('No Products added yet'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  childAspectRatio: 0.8,
                                  mainAxisExtent: 230),
                          itemCount: dispay.length,
                          itemBuilder: (context, index) {
                            final product = dispay[index];
                            return ProductCard(
                                image: product.imageProduct,
                                productname: product.productName,
                                brandname: product.brand,
                                quantity: product.stockcount,
                                category: product.category,
                                sellprice: product.sellprice.toString(),
                                productmodel: product);
                          },
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
