import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../config/constants/colors.dart';
import '../../widgets/appbar.dart';
import '../../widgets/user_avatar.dart';
import '../profile/bloc/profile_bloc.dart';

class GenerateQR extends StatefulWidget {
  static const String routeName = '/generateqr';

  const GenerateQR({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return const GenerateQR();
        });
  }

  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  String? qrData;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Flutter People Barcode',
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            qrData = state.user.email!;
            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.profileDark, AppColors.profileLight],
                      end: Alignment.bottomCenter,
                      begin: Alignment.centerLeft)),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.qrcode),
                            const SizedBox(width: 10),
                            Text(
                              'Scan the QR Code',
                              style: Theme.of(context).textTheme.displayMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            const SizedBox(
                              width: 50,
                              height: 50,
                              child: UserAvatar(
                                image: 'assets/images/happy.png',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              state.user.email!,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Card(
                          child: QrImage(
                            size: 200,
                            data: qrData!,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            const Icon(
                              FontAwesomeIcons.locationPin,
                              size: 18,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              state.user.location!,
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                'assets/images/logo.png',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'social',
                              style: Theme.of(context).textTheme.displaySmall,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return const Text('Something went wrong...');
        },
      ),
    );
  }
}
