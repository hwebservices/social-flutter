import 'dart:ui';

import 'package:flutter/material.dart';

class UserMessageDialog extends StatelessWidget {
  final Text title;
  final Widget content;
  final Function() continueCallBack;
  final Function() stopCallBack;
  final List<Widget> actions;

  const UserMessageDialog({
    super.key,
    required this.content,
    required this.title,
    required this.continueCallBack,
    required this.stopCallBack,
    required this.actions,
  });

  final TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        title: title,
        content: content,
        actions: const [],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        contentPadding: const EdgeInsets.only(top: 10.0),
      ),
    );
  }
}
