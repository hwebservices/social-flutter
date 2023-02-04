import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'config/app/app_router.dart';
import 'config/app/theme.dart';
import 'config/database/database_repository.dart';
import 'features/blocs.dart';
import 'features/cubits.dart';
import 'features/onboarding/z_onboarding.dart';
import 'features/people/pages/member_profile.dart';
import 'features/repositories.dart';
import 'features/splash/splashscreen.dart';
import 'features/users/cubit/searchpeople_cubit.dart';
import 'providers/userdata.dart';

import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp(
      // name: 'social-hwebservices',
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    Provider<UserData>(create: (context) => UserData()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? status;
  void getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      status = prefs.getString('loggedIn');
    });
    print('The shared preferences status is $status');
  }

  @override
  void initState() {
    super.initState();
    getLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => ForgotPasswordRepository()),
        RepositoryProvider(create: (context) => DatabaseRepository()),
        RepositoryProvider(create: (context) => StorageRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<SignupCubit>(
              create: (context) =>
                  SignupCubit(authRepository: context.read<AuthRepository>()),
              child: const OnboardingScreen()),
          BlocProvider<ForgotPasswordCubit>(
            create: (context) => ForgotPasswordCubit(
                resetPassword: context.read<ForgotPasswordRepository>()),
          ),
          BlocProvider<SearchPeopleCubit>(
            create: (context) =>
                SearchPeopleCubit(peopleRepository: PeopleRepository()),
            child: Container(),
          ),
          BlocProvider<MembersCubit>(
            create: (context) =>
                MembersCubit(peopleRepository: PeopleRepository()),
            child: const MemberProfile(),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              authBloc: BlocProvider.of<AuthBloc>(context),
              databaseRepository: context.read<DatabaseRepository>(),
            )..add(
                LoadProfile(
                    userId: BlocProvider.of<AuthBloc>(context).state.user!.uid),
              ),
          ),
          BlocProvider(
            create: (context) => PeopleBloc(
              peopleRepository: PeopleRepository(),
              authBloc:
                  AuthBloc(authRepository: context.read<AuthRepository>()),
            )..add(const LoadPeople(userId: '')),
          ),
          BlocProvider<ImageBloc>(
            create: (context) => ImageBloc(
                databaseRepository: DatabaseRepository(),
                storageRepository: StorageRepository())
              ..add(
                const LoadImage(imageUrls: []),
              ),
          ),
          BlocProvider(
            create: (context) => UsersBloc(usersRepository: UsersRepository())
              ..add(const LoadUsers(email: '')),
          )
        ],
        child: MaterialApp(
          builder: (context, child) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, child!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(450, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
              ],
              background: Container(color: const Color(0xFFF5F5F5))),
          title: 'social',
          routes: {
            MemberProfile.routeName: (context) => const MemberProfile(),
          },
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          onGenerateRoute: AppRouter.onGenerateRoute,
          theme: theme(),
          // home: OnboardingScreen(),
        ),
      ),
    );
  }
}
