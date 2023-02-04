import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:social/widgets/custombtn.dart';
import 'package:social/widgets/header.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../widgets/custom_textfield.dart';
import '../cubits.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.8;
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return KeyboardDismisser(
          gestures: const [GestureType.onTap],
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
              child: SizedBox(
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('STEP 1 OF 5',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    color: Theme.of(context).backgroundColor,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(height: 7),
                        const CustomTextHeader(
                            text: 'Choose a Unique Username', fontSize: 16),
                        const SizedBox(height: 7),
                        CustomTextField(
                            obscureText: false,
                            hint: 'johndoe',
                            icon: EvaIcons.person,
                            onChanged: (value) {
                              context
                                  .read<SignupCubit>()
                                  .usernamechanged(value);
                              print(state.username);
                            }),
                        const SizedBox(height: 30),
                        const CustomTextHeader(
                          text: 'What\'s Your Email Address?',
                          fontSize: 16,
                        ),
                        const SizedBox(height: 7),
                        CustomTextField(
                          obscureText: false,
                          hint: 'johndoe@gmail.com',
                          icon: Icons.email,
                          onChanged: (value) {
                            context.read<SignupCubit>().emailChanged(value);
                            print(state.email);
                          },
                        ),
                        const SizedBox(height: 30),
                        const CustomTextHeader(
                          text: 'Choose a Password',
                          fontSize: 16,
                        ),
                        const SizedBox(height: 7),
                        CustomTextField(
                          obscureText: true,
                          icon: EvaIcons.lock,
                          hint: '********',
                          onChanged: (value) {
                            context.read<SignupCubit>().passwordChanged(value);
                            print(state.password);
                          },
                        ),
                        const SizedBox(height: 7),
                        state.isPasswordValid
                            ? TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                                label: Text(
                                  'Well done',
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ))
                            : Text(
                                'at least 8 characters',
                                style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                      ],
                    ),
                    Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 5,
                          currentStep: 1,
                          selectedColor: Theme.of(context).backgroundColor,
                          unselectedColor: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: state.isFormValid && state.isPasswordValid,
                          child: CustomButton(
                              tabController: tabController, text: 'NEXT STEP'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
