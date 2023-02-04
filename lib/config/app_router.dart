import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/pages/signin/forgot_password.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/onboardinng_screen.dart';
import '../features/people/pages/people/people_list.dart';
import '../features/qrcode/qrcode.dart';
import '../features/qrcode/scanqrcode.dart';
import '../features/repositories.dart';
import '../features/splash/splashscreen.dart';
import '../features/profile/pages/edit_profile.dart';
import '../features/profile/pages/profile.dart';
import '../widgets/bloc.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    print(settings);

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      // case ProfileScreen.routeName:
      //   return ProfileScreen.route(user: settings.arguments as User);
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case ForgotPassword.routeName:
        return ForgotPassword.route();
      case Profile.routeName:
        return Profile.route();
      case EditProfile.routeName:
        return EditProfile.route();
      case GenerateQR.routeName:
        return GenerateQR.route();
      case ScanQR.routeName:
        return ScanQR.route();
      case PeopleList.routeName:
        return PeopleList.route();
      case TestingBloc.routeName:
        return TestingBloc.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('error')),
        body: TextButton(
          onPressed: () {
            RepositoryProvider.of<AuthRepository>(context).signOut();
          },
          child: Center(
            child: Text(
              'Sign Out',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
