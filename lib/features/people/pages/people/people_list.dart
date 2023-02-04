import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social/widgets/appbar.dart';
import 'package:social/widgets/card_people.dart';
import 'package:social/widgets/icon_title.dart';
import 'package:social/widgets/message_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/screen_arguments.dart';
import '../../../../widgets/user_avatar.dart';
import '../../../blocs.dart';
import '../../../repositories.dart';
import 'member_profile.dart';

class PeopleList extends StatefulWidget {
  static const String routeName = '/people';

  const PeopleList({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return const PeopleList();
        });
  }

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList>
    with SingleTickerProviderStateMixin {
  String? image;

  Future<void> _showDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<PeopleBloc, PeopleState>(
          builder: (context, state) {
            if (state is PeopleLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PeopleLoaded) {
              return MessageDialog(
                continueCallBack: () {
                  context
                      .read<PeopleBloc>()
                      .add(DeletePeople(email: state.people[index].email!));
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context);
                    setState(() {});
                  });
                },
                title: Text(
                  'Are you sure?',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).backgroundColor,
                  ),
                ),
                content: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.center,
                      colors: [
                        Theme.of(context).secondaryHeaderColor,
                        Theme.of(context).backgroundColor,
                      ],
                    ),
                  ),
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'If you remove this member from your list you will have to scan his qrcode to add him again.',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                stopCallBack: () {
                  Navigator.of(context).pop();
                },
              );
            }
            return const Text('Something went wrong...');
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'People',
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'scan',
            style: GoogleFonts.roboto(
              fontSize: 22,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Icon(
                FontAwesomeIcons.qrcode,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () {
              print('pressed to scan');
              Navigator.of(context).pushNamed('/scanqr');
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => PeopleBloc(
            peopleRepository: PeopleRepository(),
            authBloc: AuthBloc(authRepository: AuthRepository())),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            if (profileState is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (profileState is ProfileLoaded) {
              return BlocBuilder<PeopleBloc, PeopleState>(
                builder: (context, peopleState) {
                  if (peopleState is PeopleLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  print('The people state is: $peopleState');
                  if (peopleState is PeopleLoaded) {
                    return Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/scafold_bkg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          TitleWithIcon(
                                              icon:
                                                  FontAwesomeIcons.peopleGroup,
                                              title: 'My People')
                                        ]),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: ListView.separated(
                                          itemCount: peopleState.people.length,
                                          itemBuilder: ((context, index) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerRight,
                                                  end: Alignment.center,
                                                  colors: [
                                                    Theme.of(context)
                                                        .backgroundColor,
                                                    Theme.of(context)
                                                        .primaryColor,
                                                  ],
                                                ),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    MemberProfile.routeName,
                                                    arguments: ScreenArguments(
                                                        index: peopleState
                                                            .people
                                                            .indexWhere((item) =>
                                                                item.email ==
                                                                peopleState
                                                                    .people[
                                                                        index]
                                                                    .email!),
                                                        user: userdata(
                                                            peopleState
                                                                .people[index]
                                                                .email!),
                                                        email: peopleState
                                                            .people[index]
                                                            .email!),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        CardPeople(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          leading: UserAvatar(
                                                              image: image),
                                                          title: Text(
                                                            peopleState
                                                                .people[index]
                                                                .username!,
                                                            style: GoogleFonts.roboto(
                                                                fontSize: 30,
                                                                color: Theme.of(
                                                                        context)
                                                                    .secondaryHeaderColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          subtitle: Text(
                                                            peopleState
                                                                .people[index]
                                                                .email!,
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 18,
                                                              color: Theme.of(
                                                                      context)
                                                                  .secondaryHeaderColor,
                                                            ),
                                                          ),
                                                          trailing: IconButton(
                                                            icon: Icon(
                                                              FontAwesomeIcons
                                                                  .xmark,
                                                              size: 30,
                                                              color: Theme.of(
                                                                      context)
                                                                  .backgroundColor,
                                                            ),
                                                            onPressed: () {
                                                              print(
                                                                  'remove users');
                                                              _showDialog(
                                                                  context,
                                                                  index);
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: LayoutBuilder(
                                                            builder: (BuildContext
                                                                    context,
                                                                BoxConstraints
                                                                    constraints) {
                                                              return Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const SizedBox(height: 20);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const Text('Something went wrong...');
                },
              );
            }
            return const Text('Something went wrong...');
          },
        ),
      ),
    );
  }

  userdata(String email) {
    context.read<UsersBloc>().add(LoadUsers(email: email));
  }
}
