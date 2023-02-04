import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/config/constatns/colors.dart';

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color? color;

  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(icon), onPressed: () {}, color: AppColors.iconLight),
        Text(title,
            style: GoogleFonts.roboto(
                fontSize: 16,
                color: AppColors.textfieldTitle,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
