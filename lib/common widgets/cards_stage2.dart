import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardsStage2 extends StatelessWidget {
  const CardsStage2(
      {super.key,
      required this.height,
      required this.width,
       required this.cardBackgroundColor,
      required this.headText,
      required this.subText});
  final double height;
  final double width;
  final Color cardBackgroundColor;
  final String headText;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          color: cardBackgroundColor.withOpacity(0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  headText,
                  style: GoogleFonts.poppins(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
            
                Text(
                  subText,
                 style:  GoogleFonts.afacad(
                      fontSize: 50, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
