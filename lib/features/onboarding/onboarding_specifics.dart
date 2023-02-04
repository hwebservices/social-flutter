import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:social/widgets/custom_textfield.dart';
import 'package:social/widgets/custombtn.dart';
import 'package:social/widgets/header.dart';

import '../../config/constants/list_of_personas.dart';
import '../cubits.dart';

class Demo extends StatefulWidget {
  final TabController tabController;

  const Demo({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  bool selected = false;
  String? currentSelectedValue;
  String? currentSelectGender;

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
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('STEP 2 OF 5',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Theme.of(context).backgroundColor,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 7),
                        CustomTextHeader(
                          text: 'What\'s Your Persona?',
                          fontSize: 16,
                        ),
                        const SizedBox(height: 20),
                        FormField(builder: (FormFieldState state) {
                          return InputDecorator(
                            expands: false,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context).primaryColor,
                                labelStyle:
                                    GoogleFonts.poppins(color: Colors.black),
                                errorStyle: const TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                hintStyle:
                                    GoogleFonts.poppins(color: Colors.black),
                                border: InputBorder.none),
                            isEmpty: currentSelectedValue == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                focusColor: Colors.white,
                                dropdownColor: Colors.white,
                                hint: Text(
                                  'Select your persona',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 12,
                                  ),
                                ),
                                value: currentSelectedValue,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    currentSelectedValue = newValue;
                                    state.didChange(newValue);
                                    selected = true;
                                    context
                                        .read<SignupCubit>()
                                        .genderChanged(newValue!);
                                  });
                                },
                                items: Personas.personas.map((dynamic value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 100),
                        CustomTextHeader(
                          text: 'What\'s Your Age?',
                          fontSize: 16,
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          icon: Icons.numbers,
                          hint: 'ex. 25',
                          onChanged: (value) {
                            context.read<SignupCubit>().ageChanged(value);
                            print(state.age);
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 5,
                          currentStep: 2,
                          selectedColor: Theme.of(context).backgroundColor,
                          unselectedColor: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: state.isAgeValid && state.isGenderValid,
                          child: CustomButton(
                            tabController: widget.tabController,
                            text: 'NEXT STEP',
                          ),
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
