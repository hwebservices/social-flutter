// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/widgets/countdown.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../cubits.dart';
import '../../../onboarding/z_onboarding.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail>
    with TickerProviderStateMixin {
  late Timer _timer;
  bool isVerified = false;
  int levelClock = 60;
  AnimationController? _controller;

  void resendEmail() async {
    return await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));
    _controller!.forward();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        setState(() {
          isVerified = true;
        });
        timer.cancel();
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context, true);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/scafold_bkg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please, check your email inbox, and click on the email verification link. If you did not receive the email, check your spam folder.',
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  isVerified
                      ? TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.done,
                            color: Colors.green,
                            size: 20,
                          ),
                          label: Text(
                            'Authentication Confirmed',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      : const CircularProgressIndicator(color: Colors.red),
                  const SizedBox(height: 50),
                  Text(
                    'Waiting for the confirmation...',
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Center(
                    child: Countdown(
                      animation: StepTween(
                        begin: levelClock, // THIS IS A USER ENTERED NUMBER
                        end: 0,
                      ).animate(_controller!),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        const OnboardingScreen()));
                          },
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          label: Text(
                            'Cancel',
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Theme.of(context).backgroundColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
