import 'dart:io';
import 'package:e_stocker/screens/main_screens/sub_screens.dart/select_prodcuts.dart';
import 'package:flutter/material.dart';

class SelectCard extends StatelessWidget {
  final String id;
  final String productName;
  final int stockCount;
  final int productPrice;
  final String imageUrl;
  final VoidCallback onAddtoCart;
  final VoidCallback onRemoveFromCart;

  const SelectCard({
    super.key,
    required this.productName,
    required this.stockCount,
    required this.productPrice,
    required this.imageUrl,
    required this.id,
    required this.onAddtoCart,
    required this.onRemoveFromCart,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedProducts,
      builder: (context, selectedList, child) {
        bool isInCart = selectedList.any((item) => item.productId == id);

        return Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.file(
                  File(imageUrl),
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported,
                      size: 80,
                      color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text("Stock: $stockCount",
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 5),
                    Text("Price: ₹$productPrice",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    (stockCount == 0)
                        ? Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(
                                'Out of Stock',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                          )
                        : Center(
                            child: ElevatedButton(
                              onPressed:
                                  isInCart ? onRemoveFromCart : onAddtoCart,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isInCart ? Colors.red : Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                elevation: 4,
                              ),
                              child: Text(
                                isInCart ? 'Remove ' : 'Add to Cart',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
