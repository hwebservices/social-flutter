import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/widgets/custom_textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../cubits.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/resetpassword';

  const ForgotPassword({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const ForgotPassword(),
    );
  }

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.error == 'no-error') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).primaryColor,
                content: Text(
                  'Instructions to reset password sent to ${state.email}',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).backgroundColor,
                  ),
                )));
          }
        },
        builder: (context, state) {
          return KeyboardDismisser(
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
                                text: '',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\nPassword Reset',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('type your email below:',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                )),
                            const SizedBox(height: 10),
                            CustomTextField(
                                obscureText: false,
                                hint: 'johndoe@gmail.com',
                                icon: Icons.email,
                                onChanged: (value) {
                                  context
                                      .read<ForgotPasswordCubit>()
                                      .emailChanged(value);
                                  print(state.email);
                                }),
                            const SizedBox(height: 50),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(Icons.cancel,
                                      color: Colors.red),
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
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                              child: Visibility(
                                visible: state.isEmailValid,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    print('reset password pressed');

                                    context
                                        .read<ForgotPasswordCubit>()
                                        .resetUserPassword();
                                    if (state.status ==
                                        ForgotPasswordStatus.error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(state.error!)));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Center(
                                      child: Text(
                                        'Reset Password',
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
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
          );
        },
      ),
    );
  }
}
