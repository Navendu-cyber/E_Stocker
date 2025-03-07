import 'package:e_stocker/custom%20functions/string_operations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  final String saleId;
  final String customerName;
  final DateTime dateTime;
  final String totalProducts;
  final int totalMoney;
  final String phone;
  final VoidCallback onDelete;
  final VoidCallback onPdfDownload;

  const HistoryCard({
    super.key,
    required this.saleId,
    required this.customerName,
    required this.dateTime,
    required this.totalProducts,
    required this.totalMoney,
    required this.onDelete,
    required this.onPdfDownload,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    capitalizeFirstLetter(customerName),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    DateFormat('dd MMM yyyy').format(dateTime),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                ),
                const SizedBox(width: 8),
                Text(
                  'Phone: ${phone}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.shopping_bag,
                ),
                const SizedBox(width: 8),
                Text(
                  'Products: ${totalProducts}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Total: ₹  ${totalMoney.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /*   TextButton.icon(
                  onPressed: onPdfDownload,
                  icon: const Icon(
                    Icons.picture_as_pdf,
                  ),
                  label: const Text('PDF'),
                ), */
                const SizedBox(width: 10),
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(
                    color: Colors.red,
                    Icons.delete,
                  ),
                  label: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
