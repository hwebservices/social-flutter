import 'dart:ui';

import 'package:flutter/material.dart';

class BlurryDialog extends StatelessWidget {
  const BlurryDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.continueCallBack,
  }) : super(key: key);

  final Text title;
  final Text content;
  final Function() continueCallBack;
  final TextStyle textStyle = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              continueCallBack();
            },
          ),
        ],
      ),
    );
  }
}
