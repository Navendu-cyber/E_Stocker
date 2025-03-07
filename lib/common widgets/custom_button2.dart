import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final VoidCallback onpress;
  final String text;
  final Icon icon;
  CustomButton2(
      {super.key,
      required this.onpress,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 72, 72, 72),
                    const Color.fromARGB(255, 0, 0, 0)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: onpress,
                icon: icon,
                label: Text(text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
