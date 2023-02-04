import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.icon,
    this.onChanged,
    this.focusNode,
    required this.obscureText,
    this.keyboardType,
    this.controller,
    this.decoration,
    this.errorText,
  }) : super(key: key);

  final String hint;
  final IconData icon;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
        suffixIcon: Icon(icon, color: Colors.redAccent),
        hintStyle: GoogleFonts.aBeeZee(
          fontSize: 13,
          color: Colors.grey,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorText: errorText,
      ),
      onChanged: onChanged,
      focusNode: focusNode,
    );
  }
}
