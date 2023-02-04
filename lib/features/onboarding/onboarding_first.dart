import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/config/constants/colors.dart';
import 'package:social/widgets/custombtn.dart';

import '../auth/pages/signin/signin.dart';

class Start extends StatefulWidget {
  final TabController tabController;

  const Start({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 50),
              Text(
                'Welcome to social'.toUpperCase(),
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: AppColors.backgroungColor,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SigninPage()));
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.aBeeZee(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign in',
                        style: GoogleFonts.aBeeZee(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                  tabController: widget.tabController, text: 'GET STARTED'),
            ],
          ),
        ],
      ),
    );
  }
}
