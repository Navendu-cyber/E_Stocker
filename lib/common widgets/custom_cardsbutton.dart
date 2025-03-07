import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  final String text;
  final Color? cols;
  final IconData iconc;
  final GestureTapCallback? ontapp;

  const CustomCard({
    super.key,
    required this.text,
    this.cols,
    required this.iconc,
    required this.ontapp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: ontapp,
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: cols ?? Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(iconc, size: 30, color: Theme.of(context).primaryColor),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 20, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
