import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social/config/constatns/colors.dart';
import 'package:social/widgets/custom_icon.dart';
import 'package:social/widgets/icon_title.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/database/database_repository.dart';
import '../../../widgets/custom_text_container.dart';
import '../../../widgets/rect_option.dart';
import '../../blocs.dart';
import '../../onboarding/z_onboarding.dart';
import '../../repositories.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/profile';

  const Profile({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? const OnboardingScreen()
              : const Profile();
        });
  }

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            height: height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.profileDark, AppColors.profileLight],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topLeft)),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => ProfileBloc(
                        databaseRepository: DatabaseRepository(),
                        authBloc: AuthBloc(authRepository: AuthRepository()))),
                BlocProvider(
                    create: (context) => ImageBloc(
                        databaseRepository: DatabaseRepository(),
                        storageRepository: StorageRepository())),
              ],
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProfileLoaded) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 80.0, 15.0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 150,
                            child: Stack(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      RectOption(
                                          icon: const CustomIcon(
                                              icon: FontAwesomeIcons.qrcode,
                                              size: 25,
                                              color: AppColors.iconLight),
                                          onTap: () => Navigator.of(context)
                                              .pushNamed('/generateqr'))
                                    ]),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 2.0, sigmaY: 2.0),
                                            child: Container(
                                              width: 50.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12.0)),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: InkWell(
                                                child: const Icon(Icons.edit,
                                                    color: Colors.white),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          '/editprofile');
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 2.0, sigmaY: 2.0),
                                            child: Container(
                                              width: 50.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12.0)),
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.0,
                                                ),
                                              ),
                                              child: InkWell(
                                                child: const Icon(
                                                    Icons.settings,
                                                    color: Colors.white),
                                                onTap: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.green,
                                              Colors.yellow,
                                              Colors.red,
                                              Colors.purple
                                            ],
                                          ),
                                          shape: BoxShape.circle)),
                                ),
                                Positioned(
                                  right: 150,
                                  left: 150,
                                  top: 10,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Colors.white,
                                            Colors.black
                                          ]),
                                          shape: BoxShape.circle),
                                      child: Container(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Column(children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  state.user.name!,
                                  style: GoogleFonts.roboto(
                                      fontSize: 25,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  ' | ',
                                  style: GoogleFonts.roboto(
                                      fontSize: 25,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(width: 10.0),
                                Text(state.user.gender.toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 25,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic,
                                    )),
                                const SizedBox(width: 10.0),
                                Text(
                                  '(${state.user.age!} yo)',
                                  style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              state.user.location!,
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic),
                            )
                          ]),
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  state.user.bio!,
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Divider(
                              thickness: 1.0,
                              color: Theme.of(context).primaryColor),
                          const TitleWithIcon(
                              title: 'Pictures', icon: Icons.image),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 130,
                            width: width,
                            child: ListView.separated(
                              separatorBuilder: (contenxt, index) {
                                return const SizedBox(width: 15);
                              },
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.user.imageUrls!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 2,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  child: Image.network(
                                      state.user.imageUrls![index],
                                      width: 120,
                                      fit: BoxFit.fill),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Divider(
                              thickness: 1.0,
                              color: Theme.of(context).primaryColor),
                          const TitleWithIcon(
                              title: 'Interests', icon: Icons.interests),
                          GridView.count(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            childAspectRatio: 2.5,
                            mainAxisSpacing: 10,
                            crossAxisCount: 3,
                            children: state.user.interests!.map((interest) {
                              return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomTextContainer(
                                      onPressed: () {}, text: interest));
                            }).toList(),
                          )
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: Text('Something went wrong...',
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                border: Border.all(color: Colors.white, width: 1.0)),
            child: InkWell(
              child: const CustomIcon(
                  icon: FontAwesomeIcons.marsDouble,
                  size: 20,
                  color: AppColors.iconLight),
              onTap: () {
                Navigator.of(context).pushNamed('/people');
              },
            ),
          ),
        ),
      ),
    );
  }
}
