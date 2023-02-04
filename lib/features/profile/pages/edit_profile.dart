import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social/widgets/customeditbtn.dart';
import 'package:social/widgets/icon_title.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../config/constatns/colors.dart';
import '../../../config/constatns/list_of_interests.dart';
import '../../../config/constatns/list_of_personas.dart';
import '../../../config/database/database_repository.dart';
import '../../../services/geolocation.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/custom_text_container.dart';
import '../../../widgets/custom_textfield.dart';
import '../../blocs.dart';
import '../../cubits.dart';
import '../../repositories.dart';
import 'changes_profile.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = '/editprofile';
  const EditProfile({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return const EditProfile();
        });
  }

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isSelect = false;
  final int isSelected = 0;
  final List seletctedInterest = [];
  List interests = [];

  bool selected = false;
  String? currentSelectedValue;
  String? currentSelectGender;
  List persona = [];

  final _permission = GeolocatorService();
  double? lat;
  double? long;
  String? city;
  String? country;

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

    List<double> pos = <double>[];
    pos.add(lat!);
    pos.add(long!);

    return pos;
  }

  @override
  void initState() {
    super.initState();
    interests = Interests.interest;
    persona = Personas.personas;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: Scaffold(
        appBar: GradientAppBar(title: 'Edit Profile'),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            if (profileState is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (profileState is ProfileLoaded) {
              return BlocBuilder<SignupCubit, SignupState>(
                builder: (context, signupState) {
                  return SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            AppColors.profileDark,
                            AppColors.profileLight
                          ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const TitleWithIcon(
                                  title: 'Pictures', icon: Icons.image),
                              const SizedBox(width: 10),
                              SelectChangeProfile(
                                  text: 'Upload',
                                  onTap: () async {
                                    ImagePicker picker = ImagePicker();
                                    final XFile? image = await picker.pickImage(
                                        source: ImageSource.gallery);
                                    if (image != null) {
                                      await StorageRepository()
                                          .uploadImage(image);
                                      await DatabaseRepository()
                                          .getImages()
                                          .then((value) =>
                                              BlocProvider.of<ImageBloc>(
                                                      context)
                                                  .add(UpdateUserImages(
                                                      image: value!)));
                                    }
                                  },
                                  icon: FontAwesomeIcons.upload),
                            ],
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<ImageBloc, ImageState>(
                              builder: (context, imageState) {
                            if (imageState is ImagesLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (imageState is ImagesLoaded) {
                              return SizedBox(
                                height: 200,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0),
                                    child: ListView.separated(
                                        separatorBuilder: (contenxt, index) {
                                          return const SizedBox(width: 15);
                                        },
                                        shrinkWrap: false,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imageState.imageUrls.length,
                                        itemBuilder: (context, index) {
                                          return Stack(children: [
                                            Image.network(
                                                imageState.imageUrls[index],
                                                width: 150.0,
                                                height: 200.0,
                                                fit: BoxFit.fill),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, left: 70.0),
                                                child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: IconButton(
                                                        icon: Icon(
                                                            Icons
                                                                .delete_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary,
                                                            size: 32),
                                                        onPressed: () async {
                                                          await DatabaseRepository()
                                                              .getImages()
                                                              .then(
                                                                  (value) async {
                                                            var url = value!
                                                                .elementAt(
                                                                    index);
                                                            await StorageRepository()
                                                                .deleteImage(
                                                                    url);
                                                            BlocProvider.of<
                                                                        ImageBloc>(
                                                                    context)
                                                                .add(DeleteImage(
                                                                    url: url));
                                                          });
                                                        })))
                                          ]);
                                        })),
                              );
                            }
                            return const Text('Something went wrong...');
                          }),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const TitleWithIcon(
                                  title: 'Bio', icon: Icons.description),
                              const SizedBox(width: 10),
                              SelectChangeProfile(
                                text: 'Update',
                                icon: Icons.description,
                                onTap: () {
                                  context.read<SignupCubit>().updateBio();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextField(
                                obscureText: false,
                                icon: Icons.description,
                                hint: profileState.user.bio!,
                                onChanged: (value) {
                                  context.read<SignupCubit>().biochange(value);
                                }),
                          ),
                          const SizedBox(height: 10),
                          Row(children: [
                            const TitleWithIcon(
                                title: 'Interests', icon: Icons.interests),
                            const SizedBox(width: 10),
                            SelectChangeProfile(
                              text: 'Update',
                              icon: Icons.description,
                              onTap: () {
                                context.read<SignupCubit>().updateInterest();
                              },
                            )
                          ]),
                          const SizedBox(height: 10),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 4.5,
                              width: double.infinity,
                              child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    childAspectRatio: 2.5,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 3,
                                    children: interests.map(
                                      (interest) {
                                        return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: CustomTextContainer(
                                                isSelected: seletctedInterest
                                                        .contains(interest)
                                                    ? true
                                                    : false,
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      if (seletctedInterest
                                                          .contains(interest)) {
                                                        seletctedInterest
                                                            .remove(interest);
                                                      } else {
                                                        seletctedInterest
                                                            .add(interest);
                                                        context
                                                            .read<SignupCubit>()
                                                            .interestSelected(
                                                                seletctedInterest);
                                                      }
                                                    },
                                                  );
                                                },
                                                text: interest));
                                      },
                                    ).toList(),
                                  ))),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const TitleWithIcon(
                                    title: 'Persona',
                                    icon: FontAwesomeIcons.user,
                                  ),
                                  const SizedBox(width: 10),
                                  SelectChangeProfile(
                                      onTap: () => context
                                          .read<SignupCubit>()
                                          .updateGender(),
                                      icon: Icons.description,
                                      text: 'Update')
                                  //
                                ],
                              ),
                              const SizedBox(height: 10),
                              DropdownButton<String>(
                                focusColor: Colors.white,
                                dropdownColor: Colors.white,
                                hint: Text(
                                  'Select your persona',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                value: currentSelectedValue,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(
                                    () {
                                      currentSelectedValue = newValue;

                                      selected = true;
                                      context
                                          .read<SignupCubit>()
                                          .genderChanged(newValue!);
                                    },
                                  );
                                  print(signupState.gender);
                                },
                                items: persona.map(
                                  (dynamic value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const TitleWithIcon(
                                  title: 'Age', icon: Icons.numbers),
                              const SizedBox(width: 10),
                              SelectChangeProfile(
                                  onTap: () =>
                                      context.read<SignupCubit>().updateAge(),
                                  icon: Icons.description,
                                  text: 'Update')
                              //
                            ],
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            icon: Icons.numbers,
                            hint: 'ex. 25',
                            onChanged: (value) {
                              context.read<SignupCubit>().ageChanged(value);
                              print(signupState.age);
                            },
                            // controller: controller,
                          ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const TitleWithIcon(
                                      title: 'Location',
                                      icon: FontAwesomeIcons.locationArrow),
                                  const SizedBox(width: 10),
                                  SelectChangeProfile(
                                      onTap: () => context
                                          .read<SignupCubit>()
                                          .updateLocation(),
                                      icon: Icons.description,
                                      text: 'Update')
                                ],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      obscureText: false,
                                      icon: Icons.location_on,
                                      hint: 'E.g New York, United States',
                                      onChanged: (value) {
                                        context
                                            .read<SignupCubit>()
                                            .locationChanged(value);
                                        print(profileState.user.location);
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              city != null
                                                  ? Text(
                                                      '$city,',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 15,
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  : Text(
                                                      'Press the buttom below',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 15,
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                              const SizedBox(width: 10),
                                              country != null
                                                  ? Text(
                                                      '$country',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 15,
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  : const Text('-'),
                                              const SizedBox(width: 10),
                                              InkWell(
                                                onTap: () async {
                                                  print('tapped');
                                                  await Clipboard.setData(
                                                    ClipboardData(
                                                        text:
                                                            '$city, $country'),
                                                  ).then(
                                                    (_) => {
                                                      ScaffoldMessenger.of(
                                                              context)
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
                                                    color: Colors.red,
                                                    size: 25),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: CustomEditButton(
                              text: 'Done',
                              onPressed: _moveToProfile,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Text('Something went wrong...');
          },
        ),
      ),
    );
  }

  void _moveToProfile() {
    Navigator.of(context).pop();
  }
}
