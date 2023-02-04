import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/config/constants/colors.dart';

import '../config/instances/login_status.dart';
import '../features/auth/cubit/signup_cubit.dart';
import '../features/auth/pages/signup/email_verification.dart';
import '../features/home/home_screen.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final void function;

  const CustomButton({
    Key? key,
    required this.tabController,
    required this.text,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.centerRight,
          colors: [AppColors.buttonDark, AppColors.buttonLight],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (tabController.index != 6) {
            tabController.animateTo(tabController.index + 1);
          } else {
            context.read<SignupCubit>().updateLocation();
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => HomeScreen()));
            Instances.saveLoginStatus('loggedIn');
          }

          if (tabController.index == 3) {
            context.read<SignupCubit>().signUpWithCredentials();
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const VerifyEmail()));
          }
          if (tabController.index == 4) {
            context.read<SignupCubit>().updateAge();
            context.read<SignupCubit>().updateGender();
          }
          if (tabController.index == 6) {
            context.read<SignupCubit>().updateBio();
            context.read<SignupCubit>().updateInterest();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(text,
                style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ),
      ),
    );
  }
}
