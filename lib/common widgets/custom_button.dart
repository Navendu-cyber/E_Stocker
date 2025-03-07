import 'package:e_stocker/database/db_models/theme_switching.dart';
import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  final VoidCallback onpress;
  final String hintTextt;
  const CustomButton1(
      {super.key, required this.onpress, required this.hintTextt});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 200,
      child: OutlinedButton(
        onPressed: () {
          onpress();
        },
        child: Text(
          hintTextt,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color:
                ThemeSwitching.isDArkmode.value ? Colors.white : Colors.black,
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(10),
          side: BorderSide(
              color:
                  ThemeSwitching.isDArkmode.value ? Colors.white : Colors.black,
              width: 1.5),
        ),
      ),
    );
  }
}
