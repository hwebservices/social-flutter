import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/constatns/colors.dart';
import '../../../widgets/custom_icon.dart';

class SelectChangeProfile extends StatelessWidget {
  const SelectChangeProfile({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Function() onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 25,
          width: 80,
          decoration: BoxDecoration(
              color: AppColors.buttonLight,
              borderRadius: BorderRadius.circular(18.0)),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIcon(color: AppColors.iconDark, icon: icon, size: 12),
                const SizedBox(width: 5),
                Text(text,
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500))
              ])),
    );
  }
}
