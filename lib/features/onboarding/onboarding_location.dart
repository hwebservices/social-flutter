import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/services/geolocation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:social/widgets/custom_textfield.dart';
import 'package:social/widgets/custombtn.dart';
import 'package:social/widgets/header.dart';
import 'package:flutter/services.dart';

import '../cubits.dart';

class Location extends StatefulWidget {
  final TabController tabController;

  const Location({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _permission = GeolocatorService();
  double? lat;
  double? long;
  String? city;
  String? country;

  final TextEditingController _controller = TextEditingController();

  Future<List<double>> getLatLong() async {
    lat =
        await _permission.getCurrentPosition().then((value) => value!.latitude);
    long = await _permission
        .getCurrentPosition()
        .then((value) => value!.longitude);
    print(lat);
    print(long);
    List<Placemark> placemarks = await placemarkFromCoordinates(lat!, long!);
    setState(() {
      city = placemarks[0].locality;
      country = placemarks[0].country;
    });

    print(city);
    print(country);
    List<double> pos = <double>[];
    pos.add(lat!);
    pos.add(long!);

    return pos;
  }

  @override
  void initState() {
    super.initState();
    _permission.hasPermission();
    getLatLong();
  }

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('STEP 5 OF 5',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Theme.of(context).backgroundColor,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 7),
                        CustomTextHeader(
                          text: 'Where Are You?',
                          fontSize: 16,
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _controller,
                          obscureText: false,
                          icon: Icons.location_on,
                          hint: 'E.g New York, United States',
                          onChanged: (value) {
                            context.read<SignupCubit>().locationChanged(value);
                            print(state.location);
                          },
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Why we ask you this?',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Because we use your current position to suggest people around to you',
                          style: GoogleFonts.roboto(
                              fontSize: 15,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      getLatLong();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  label: Text(
                                    'Get Current Location',
                                    style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        color:
                                            Theme.of(context).backgroundColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  city != null
                                      ? Text(
                                          '$city,',
                                          style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w400),
                                        )
                                      : const Text('-'),
                                  const SizedBox(width: 10),
                                  country != null
                                      ? Text(
                                          '$country',
                                          style: GoogleFonts.roboto(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w400),
                                        )
                                      : const Text('-'),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () async {
                                      print('tapped');
                                      await Clipboard.setData(
                                        ClipboardData(text: '$city, $country'),
                                      ).then(
                                        (_) => {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  '$city, $country copied to clipboard !'),
                                            ),
                                          )
                                        },
                                      );
                                    },
                                    child: const Icon(Icons.copy,
                                        color: Colors.red, size: 25),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 5,
                          currentStep: 5,
                          selectedColor: Theme.of(context).backgroundColor,
                          unselectedColor: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: state.isLocationValid,
                          child: CustomButton(
                              tabController: widget.tabController,
                              text: 'DONE'),
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
