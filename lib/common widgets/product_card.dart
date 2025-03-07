import 'dart:io';
import 'package:e_stocker/database/db_models/product_model.dart';
import 'package:e_stocker/screens/edit_screeens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final Product productmodel;
  final String image;
  final String productname;
  final String brandname;
  final int quantity;
  final String category;
  final String sellprice;

  ProductCard({
    super.key,
    required this.image,
    required this.productname,
    required this.brandname,
    required this.quantity,
    required this.category,
    required this.sellprice,
    required this.productmodel,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    bool isLowStock = quantity < 10;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              catname: category,
              product: productmodel,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image(
                      image: FileImage(File(image)),
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Text(
                        productname,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                        Icons.branding_watermark, brandname, isDarkMode),
                    _buildStockRow(quantity, isDarkMode),
                    _buildInfoRow(Icons.category, category, isDarkMode),
                    _buildPriceRow(sellprice, isLowStock, isDarkMode),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon,
              size: 18, color: isDarkMode ? Colors.white70 : Colors.black54),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockRow(int quantity, bool isDarkMode) {
    bool isLowStock = quantity < 10;
    Color textColor = isLowStock ? Colors.redAccent : Colors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(Icons.inventory, size: 18, color: textColor),
          const SizedBox(width: 6),
          Text(
            'Stock: $quantity',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String price, bool isLowStock, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.currency_rupee_rounded,
                  size: 18,
                  color: isDarkMode ? Colors.white70 : Colors.black54),
              const SizedBox(width: 6),
              Text(
                price,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
