import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/config/constatns/colors.dart';

class GradientAppBar extends StatelessWidget with PreferredSizeWidget {
  static const _defaultHeight = 56.0;

  final double elevation;
  final Gradient? gradient;
  final String title;
  final double barHeight;

  GradientAppBar({
    super.key,
    required this.title,
    this.elevation = 3.0,
    this.gradient,
    this.barHeight = _defaultHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topLeft,
                colors: [AppColors.appBarDark, AppColors.appBarLight]),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, elevation),
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 3)
            ]),
        child: AppBar(
            title: Text(
              title,
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent));
  }

  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}
