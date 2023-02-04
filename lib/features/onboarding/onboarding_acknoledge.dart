import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/widgets/custombtn.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/widgets/header.dart';

import '../cubits.dart';

class Acknoledge extends StatefulWidget {
  final TabController tabController;

  const Acknoledge({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<Acknoledge> createState() => _AcknoledgeState();
}

class _AcknoledgeState extends State<Acknoledge> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.8;
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
            child: SizedBox(
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      const Icon(Icons.block, size: 80, color: Colors.red),
                      const SizedBox(height: 7),
                      CustomTextHeader(
                        text: 'For age 18+ only',
                        fontSize: 22,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        'By clicking on PROCEED you acknoledge that you are 18+ years old and agree with the EULA conditions.',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.cancel, color: Colors.red),
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
                    ],
                  ),
                  CustomButton(
                    tabController: widget.tabController,
                    text: 'PROCEED',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
