import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextHeader extends StatelessWidget {
  const CustomTextHeader({Key? key, required this.text, required this.fontSize})
      : super(key: key);

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.aBeeZee(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ));
  }
}
