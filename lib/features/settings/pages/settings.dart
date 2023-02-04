import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social/config/constants/colors.dart';

import '../../../widgets/appbar.dart';
import '../../repositories.dart';

class Settings extends StatelessWidget {
  static const String routeName = '/settings';
  Settings({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return Settings();
        });
  }

  final logoff = AuthRepository();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: GradientAppBar(title: 'Settings'),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.profileDark, AppColors.profileLight],
                begin: Alignment.bottomCenter,
                end: Alignment.topLeft)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
              width: width * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () => logoff.signOut(),
                    child: Text(
                      'Sigout',
                      style: GoogleFonts.roboto(
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
