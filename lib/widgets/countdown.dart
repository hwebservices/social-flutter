import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation, this.clockTimer})
      : super(key: key, listenable: animation);

  final Animation<int> animation;
  Duration? clockTimer;
  bool timerFinished = false;

  bool isLapsed() {
    if (clockTimer == const Duration(seconds: 0)) {
      timerFinished = true;
    }
    return true;
  }

  @override
  build(BuildContext context) {
    clockTimer = Duration(seconds: animation.value * 60);

    String timerText =
        '${clockTimer!.inMinutes.remainder(60).toString()}:${(clockTimer!.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          timerText,
          style: GoogleFonts.roboto(
            fontSize: 30,
            color: Theme.of(context).backgroundColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: isLapsed(),
          child: Text(
            'If you still did not receive the email, make sure you have provided a valid email and start again.',
            style: GoogleFonts.roboto(
              fontSize: 15,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
