import 'package:flutter/material.dart';

Widget catogory(
    {TextEditingController? controllerr,
    required String title,
    required VoidCallback onpress1,
    required VoidCallback onpress2,
    required String button1,
    required String button2,
    required String hintText}) {
  return AlertDialog(
    title: Text(title),
    content: TextField(
    
      controller: controllerr,
      autocorrect: true,
      decoration: InputDecoration(
        filled: false,
        label: Text(hintText),
        floatingLabelBehavior: FloatingLabelBehavior.always

      ),  
    ),
    actions: [
      TextButton(
          onPressed: () {
            onpress1();
          },
          child: Text(button1)),
                TextButton(
          onPressed: () {
            onpress2();
          },
          child: Text(button2)),
    ],
  );
}
