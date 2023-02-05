import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/constants/colors.dart';
import '../../widgets/appbar.dart';
import '../blocs.dart';
import '../onboarding/z_onboarding.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state.status);
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? const OnboardingScreen()
              : const HomeScreen();
          // : OnboardingScreen();
        });
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(title: 'Social Flutter'),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.profileDark, AppColors.profileLight],
                begin: Alignment.bottomCenter,
                end: Alignment.topLeft)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/dash.gif',
                width: 330,
                height: 330,
                gaplessPlayback: false,
              ),
            ),
            Text(
              'Welcome to Social Flutter',
              style: GoogleFonts.roboto(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/profile'),
              child: Text(
                'Go to Profile',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: height * 0.3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Developed in',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset('assets/images/heart.png', width: 20, height: 20),
                const SizedBox(width: 10),
                Text(
                  'with Flutter',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
