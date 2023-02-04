import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs.dart';
import '../onboarding/z_onboarding.dart';
import '../repositories.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state.status);
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? const OnboardingScreen()
              : HomeScreen();
          // : OnboardingScreen();
        });
  }

  final logoff = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    logoff.signOut();
                    print('pressed to signout');
                    // Navigator.of(context).pushNamed('/');
                  },
                  child: const Text('Signout'),
                ),
                const SizedBox(width: 30),
                TextButton(
                  onPressed: () {
                    print('pressed to profile');
                    Navigator.of(context).pushNamed('/profile');
                  },
                  child: const Text('Go Profile'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                print('pressed to bloc');
                Navigator.of(context).pushNamed('/bloc');
              },
              child: const Text('TEST BLOC'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
