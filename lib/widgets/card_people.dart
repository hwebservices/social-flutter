import 'package:flutter/material.dart';

class CardPeople extends StatelessWidget {
  const CardPeople({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.leading,
    required this.color,
  });

  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Widget leading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: color,
      child: ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
