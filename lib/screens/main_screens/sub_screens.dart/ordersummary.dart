import 'dart:io';
import 'package:e_stocker/common%20widgets/custom_button2.dart';
import 'package:e_stocker/custom%20functions/randomid.dart';
import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_functions/sale_func.dart';
import 'package:e_stocker/database/db_models/sale_model.dart';
import 'package:e_stocker/database/db_models/selling_products.dart';
import 'package:e_stocker/notification/notification_class.dart';
import 'package:e_stocker/screens/main_screens/sub_screens.dart/select_prodcuts.dart';
import 'package:flutter/material.dart';

class Ordersummary extends StatefulWidget {
  final DateTime dateTime;
  final String customerName;
  final String customerPh;
  final String customerAddress;

  Ordersummary({
    super.key,
    required this.customerName,
    required this.customerPh,
    required this.customerAddress,
    required this.dateTime,
  });

  @override
  State<Ordersummary> createState() => _OrdersummaryState();
}

final NotificationClass notificationService = NotificationClass();

Future<void> checkLowStock() async {
  for (var product in productbox.values) {
    if (product.stockcount < 10) {
      await notificationService.showNotification(
        title: "Low Stock Alert",
        body: "${product.productName} has only ${product.stockcount} left!",
      );
    }
  }
}

class _OrdersummaryState extends State<Ordersummary> {
  int price = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Summary'), centerTitle: true),
      body: ValueListenableBuilder<List<SellingProducts>>(
        valueListenable: selectedProducts,
        builder: (context, cartItems, child) {
          int totalPrice = cartItems.fold(0, (sum, item) {
            final product = productbox.get(item.productId);
            return sum +
                (product != null
                    ? item.productQuantity * product.sellprice
                    : 0);
          });
          return cartItems.isEmpty
              ? const Center(child: Text("No products in cart"))
              : Stack(
                  children: [
                    ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        final product = productbox.get(cartItem.productId);

                        if (product == null) {
                          return const SizedBox();
                        }

                        TextEditingController quantityController =
                            TextEditingController(
                                text: cartItem.productQuantity.toString());

                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: ListTile(
                            leading: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                                image: product.imageProduct.isNotEmpty
                                    ? DecorationImage(
                                        image: FileImage(
                                            File(product.imageProduct)),
                                        fit: BoxFit.cover)
                                    : null,
                              ),
                              child: product.imageProduct.isEmpty
                                  ? const Icon(Icons.image_not_supported,
                                      size: 30, color: Colors.grey)
                                  : null,
                            ),
                            title: Text(product.productName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Price: ₹${product.sellprice}"),
                                Text("Stock: ${product.stockcount}",
                                    style: TextStyle(
                                        color: product.stockcount == 0
                                            ? Colors.red
                                            : Colors.black)),
                                Text(
                                    "Total: ₹${cartItem.productQuantity * product.sellprice}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove,
                                      color: Colors.red),
                                  onPressed: () {
                                    if (cartItem.productQuantity > 1) {
                                      cartItem.productQuantity =
                                          cartItem.productQuantity - 1;
                                      selectedProducts.value =
                                          List.from(selectedProducts.value);
                                    } else {
                                      selectedProducts.value.removeAt(index);
                                      selectedProducts.value =
                                          List.from(selectedProducts.value);
                                    }
                                  },
                                ),
                                SizedBox(
                                  width: 40,
                                  child: TextFormField(
                                    controller: quantityController,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                    onChanged: (value) {
                                      int? newQuantity = int.tryParse(value);
                                      if (newQuantity == null ||
                                          newQuantity < 1 ||
                                          newQuantity > product.stockcount) {
                                        quantityController.text =
                                            cartItem.productQuantity.toString();
                                      } else {
                                        cartItem.productQuantity = newQuantity;
                                        selectedProducts.value =
                                            List.from(selectedProducts.value);
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.black),
                                  onPressed: () {
                                    if (cartItem.productQuantity <
                                        product.stockcount) {
                                      cartItem.productQuantity =
                                          cartItem.productQuantity + 1;
                                      selectedProducts.value =
                                          List.from(selectedProducts.value);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: 350,
                            minHeight: 300,
                            maxWidth: 400,
                            minWidth: 300),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: Colors.white,
                          shadowColor: Colors.grey.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order Summary',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Divider(thickness: 1.2),
                                _buildSummaryRow(
                                    "Customer Name", widget.customerName),
                                _buildSummaryRow("Phone", widget.customerPh),
                                _buildSummaryRow(
                                    "Address", widget.customerAddress),
                                _buildSummaryRow("Total Products",
                                    cartItems.length.toString()),
                                const Divider(thickness: 1.2),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Total Price:",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "₹$totalPrice",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: CustomButton2(
                                        onpress: () {
                                          int totalPrice = selectedProducts
                                              .value
                                              .fold(0, (sum, item) {
                                            final product =
                                                productbox.get(item.productId);
                                            return sum +
                                                (product != null
                                                    ? item.productQuantity *
                                                        product.sellprice
                                                    : 0);
                                          });
                                          final sale = SaleModel(
                                              dateTime: widget.dateTime,
                                              saleid: randomid(),
                                              customerName: widget.customerName,
                                              customerPh: widget.customerPh,
                                              customerAddress:
                                                  widget.customerAddress,
                                              pruduct_quantity: List.from(
                                                  selectedProducts.value),
                                              totalPrice: totalPrice,
                                              discout: 0);

                                          addSale(sale);
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          selectedProducts.value = [];
                                          Future.delayed(Duration(seconds: 4),
                                              () {
                                            checkLowStock();
                                          });
                                        },
                                        text: 'Complete Order',
                                        icon: Icon(Icons.domain_verification)))
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
