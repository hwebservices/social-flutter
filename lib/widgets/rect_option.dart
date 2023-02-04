import 'dart:ui';

import 'package:flutter/material.dart';

class RectOption extends StatelessWidget {
  const RectOption({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Widget icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: InkWell(onTap: onTap, child: icon),
        ),
      ),
    );
  }
}
