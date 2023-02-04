// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ModalOptions extends StatelessWidget {
  const ModalOptions({
    Key? key,
    required this.options,
    required this.colors,
    required this.height,
    this.begin,
    this.end,
  }) : super(key: key);
  final List<Widget> options;
  final List<Color> colors;
  final double height;
  final Alignment? begin;
  final Alignment? end;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: begin!, end: end!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: options,
        ),
      ),
    );
  }
}
