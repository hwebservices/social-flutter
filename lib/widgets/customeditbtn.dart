import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../config/constatns/colors.dart';

class CustomEditButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const CustomEditButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.centerRight,
          colors: [
            AppColors.buttonDark,
            AppColors.buttonLight,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(text,
                style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ),
      ),
    );
  }
}
