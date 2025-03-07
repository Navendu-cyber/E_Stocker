import 'dart:io';
import 'package:e_stocker/database/db_functions/product_functions.dart';
import 'package:e_stocker/database/db_models/product_model.dart';
import 'package:e_stocker/screens/edit_screeens/product_edit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  final String catname;

  ProductDetails({super.key, required this.product, required this.catname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details'), centerTitle: true),
      body: ValueListenableBuilder(
        valueListenable: productbox.listenable(),
        builder: (context, Box<Product> box, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: FileImage(File(product.imageProduct)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).cardColor,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name & Brand
                          Text(
                            product.productName,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Brand: ${product.brand}",
                            style: GoogleFonts.poppins(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                          Divider(thickness: 1),

                          Row(
                            children: [
                              Icon(Icons.category, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                "Category:",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    catname,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _infoTile("Color", product.color),
                              _stockInfo(product.stockcount),
                            ],
                          ),
                          const SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _priceTile("Buy Price",
                                  product.buyprice.toString(), Colors.green),
                              _priceTile("Sell Price",
                                  product.sellprice.toString(), Colors.red),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => EditProduct(product: product)));
                        },
                        icon: Icon(Icons.edit, size: 20),
                        label: Text("Edit"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                  'Are you Sure to Delete this Product ?',
                                  style: TextStyle(fontSize: 20),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("No")),
                                  SizedBox(
                                    width: 110,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        deleteProduct(product.productid);
                                        getbox();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete, size: 20, color: Colors.white),
                        label: Text("Delete"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _stockInfo(int stockCount) {
    Color bgColor =
        stockCount < 10 ? Colors.red.shade700 : Colors.green.shade700;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Stock: $stockCount',
        style: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _priceTile(String title, String price, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "₹$price",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
