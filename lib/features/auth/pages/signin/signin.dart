import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../config/instances/login_status.dart';
import '../../../../widgets/alert_dialog.dart';
import '../../../cubits.dart';
import '../../../home/home_screen.dart';
import '../../../onboarding/z_onboarding.dart';
import '../../../repositories.dart';
import '../../bloc/auth_bloc.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String error = '';
  AuthRepository? authRepository;

  bool get isEmailValid => emailController.text.isNotEmpty;
  bool get isPasswordValid => passwordController.text.isNotEmpty;

  void signinUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((_) {
        Instances.saveLoginStatus('loggedIn');
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => HomeScreen(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      error = e.message!;
      _showDialog(context);
    }
  }

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlurryDialog(
          continueCallBack: () {
            Navigator.of(context).pop();
          },
          content: Text(
            error,
            style: GoogleFonts.aBeeZee(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          title: Text(
            'Attention',
            style: GoogleFonts.aBeeZee(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.9;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/connect.png',
                height: 25,
                width: 25,
                color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 5),
            Text(
              'social',
              style: GoogleFonts.aBeeZee(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          print('signinstate is ${state.status}');
          if (state.status == AuthStatus.unauthenticated) {
            print('User unauthenticated');
          } else if (state.status == AuthStatus.authenticated) {
            print('User authenticated');
          }
        },
        child: KeyboardDismisser(
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.black],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomCenter)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 11,
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Hey there,',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\nWelcome back!',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      print('Email is required');
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: const Icon(Icons.mail,
                                        color: Colors.red),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: GoogleFonts.aBeeZee(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      print('Password is required');
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    filled: true,
                                    suffixIcon: const Icon(AntIcons.lockFilled,
                                        color: Colors.red),
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: GoogleFonts.aBeeZee(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 210.0),
                                      child: TextButton(
                                        onPressed: () {
                                          print('pressed');
                                          Navigator.pushNamed(
                                              context, '/resetpassword');
                                        },
                                        child: Text(
                                          'Forgot Password?',
                                          style: GoogleFonts.aBeeZee(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OnboardingScreen()));
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Do you want to create an account? ',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Click here',
                                    style: GoogleFonts.aBeeZee(
                                      color: Theme.of(context).backgroundColor,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.centerRight,
                                colors: [
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context).primaryColor,
                                ],
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                print('signin pressed');

                                signinUser(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'Sign In',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
