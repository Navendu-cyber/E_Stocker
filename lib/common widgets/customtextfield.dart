import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTexfield extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isSecure;
  final String hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final FloatingLabelBehavior floating;
  final double padding;
  final ValueChanged<String>? onchange;

  CustomTexfield(
      {super.key,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.isSecure = false,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.labelText,
      required this.floating,
      this.padding = 3.0,
      this.onchange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextFormField(
        onChanged: onchange,
        autocorrect: true,
        autovalidateMode: autovalidateMode,
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isSecure,
        style: TextStyle(),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: floating,
          labelStyle:
              GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
          filled: false,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
