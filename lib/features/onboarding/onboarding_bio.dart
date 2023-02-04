import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:social/config/constatns/list_of_interests.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:social/widgets/custom_text_container.dart';
import 'package:social/widgets/custom_textfield.dart';
import 'package:social/widgets/custombtn.dart';
import 'package:social/widgets/header.dart';

import '../cubits.dart';

class Bio extends StatefulWidget {
  final TabController tabController;

  const Bio({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  bool isSelect = false;
  final int isSelected = 0;
  final List selectedInterest = [];
  final List interests = Interests.interest;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.8;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('STEP 4 OF 5',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 7),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextHeader(
                          text: 'Describe Yourself',
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          obscureText: false,
                          icon: Icons.description,
                          hint: 'I am a bear and I like...',
                          onChanged: (value) {
                            context.read<SignupCubit>().biochange(value);
                            print(state.bio);
                          },
                          // controller: controller,
                        ),
                        const SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextHeader(
                              text: 'Select 3 or more interests',
                              fontSize: 16,
                            ),
                            Text(
                              '${selectedInterest.length}/${interests.length}',
                            )
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.2,
                          width: double.infinity,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            child: GridView.count(
                              shrinkWrap: true,
                              childAspectRatio: 21 / 11,
                              mainAxisSpacing: 10,
                              crossAxisCount: 3,
                              children: interests.map((interest) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomTextContainer(
                                    isSelected:
                                        selectedInterest.contains(interest)
                                            ? true
                                            : false,
                                    onPressed: () {
                                      setState(
                                        () {
                                          if (selectedInterest
                                              .contains(interest)) {
                                            selectedInterest.remove(interest);
                                          } else {
                                            selectedInterest.add(interest);
                                            context
                                                .read<SignupCubit>()
                                                .interestSelected(
                                                    selectedInterest);
                                          }
                                        },
                                      );
                                      print(state.interest);
                                    },
                                    text: interest,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 5,
                          currentStep: 4,
                          selectedColor: Theme.of(context).backgroundColor,
                          unselectedColor: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: state.isBioValid,
                          child: CustomButton(
                              tabController: widget.tabController,
                              text: 'NEXT STEP'),
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
