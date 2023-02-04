import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs.dart';
import '../home/home_screen.dart';
import '../onboarding/z_onboarding.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print('Listener');
          if (state.status == AuthStatus.unauthenticated) {
            print('User unauthenticated');
            Timer(
              const Duration(seconds: 3),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                OnboardingScreen.routeName,
                ModalRoute.withName('/onboarding'),
              ),
            );
          } else if (state.status == AuthStatus.authenticated) {
            print('User authenticated');
            Timer(
              const Duration(seconds: 1),
              () => Navigator.of(context).pushNamed(HomeScreen.routeName),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon.png',
                  height: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  'social',
                  style: Theme.of(context).textTheme.headline1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
