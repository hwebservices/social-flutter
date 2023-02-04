import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social/config/constants/colors.dart';
import 'package:social/widgets/appbar.dart';
import 'package:social/widgets/icon_title.dart';
import 'package:social/widgets/message_dialog.dart';
import 'package:social/widgets/modal.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/custom_text_container.dart';
import '../../../../widgets/custom_icon.dart';
import '../../../config/app/screen_arguments.dart';
import '../../blocs.dart';
import '../../cubits.dart';

class MemberProfile extends StatefulWidget {
  const MemberProfile({super.key});

  static const routeName = '/extractArguments';

  @override
  State<MemberProfile> createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  bool hot = false;
  bool blocked = false;
  bool reported = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UsersLoaded) {
          var height = MediaQuery.of(context).size.height;
          return Scaffold(
            appBar: GradientAppBar(title: state.user.email!),
            body: SingleChildScrollView(
              child: Container(
                height: height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [AppColors.profileDark, AppColors.profileLight],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topLeft)),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 40.0, left: 20),
                              child: SizedBox(
                                  height: 200,
                                  width: 150,
                                  child: Image.network(state.user.imageUrls![0],
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.fill))),
                          const SizedBox(width: 20),
                          Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(state.user.name!,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(height: 5),
                                    Text(state.user.gender!,
                                        style: GoogleFonts.aBeeZee(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(height: 5),
                                    Row(children: [
                                      const Icon(FontAwesomeIcons.globe,
                                          size: 15, color: Colors.white),
                                      const SizedBox(width: 5),
                                      Text(state.user.location!,
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColor))
                                    ]),
                                    const SizedBox(height: 10),
                                    Row(children: [
                                      const Icon(Icons.numbers,
                                          size: 15, color: Colors.white),
                                      const SizedBox(width: 5),
                                      Text(state.user.age!,
                                          style: GoogleFonts.aBeeZee(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColor))
                                    ]),
                                    const SizedBox(height: 45),
                                    BlocBuilder<PeopleBloc, PeopleState>(
                                      builder: (context, peopleState) {
                                        if (peopleState is PeopleLoading) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (peopleState is PeopleLoaded) {
                                          return BlocConsumer<MembersCubit,
                                                  MembersState>(
                                              listener: (context, state) {},
                                              builder: (context, state) {
                                                if (state is MembersLoading) {
                                                  return SizedBox(
                                                    height: 50,
                                                    child: ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount: 1,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Row(
                                                          children: [
                                                            InkWell(
                                                                onTap: () {},
                                                                child: ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child: Container(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.2),
                                                                            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                                                            border: Border.all(color: Colors.white, width: 1.0)),
                                                                        child: const CustomIcon(icon: FontAwesomeIcons.fireFlameCurved, size: 25, color: AppColors.iconLight)))),
                                                            const SizedBox(
                                                                width: 10),
                                                            ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                                child: InkWell(
                                                                    onTap:
                                                                        () {},
                                                                    child: Container(
                                                                        width: 50.0,
                                                                        height: 50.0,
                                                                        decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.1),
                                                                          borderRadius:
                                                                              const BorderRadius.all(Radius.circular(12.0)),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                        child: const CustomIcon(icon: FontAwesomeIcons.phone, size: 25, color: AppColors.iconLight)))),
                                                            const SizedBox(
                                                                width: 10),
                                                            InkWell(
                                                                onTap: () {},
                                                                child: ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child: Container(
                                                                        width:
                                                                            50.0,
                                                                        height:
                                                                            50.0,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.1),
                                                                            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                                                            border: Border.all(color: Colors.white, width: 1.0)),
                                                                        child: const CustomIcon(icon: FontAwesomeIcons.video, size: 25, color: AppColors.iconLight)))),
                                                            const SizedBox(
                                                                width: 10),
                                                            InkWell(
                                                                onTap:
                                                                    () async {
                                                                  showModalBottomSheet(
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return ModalOptions(
                                                                          options: [
                                                                            InkWell(
                                                                                onTap: () {
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: ((context) {
                                                                                        return MessageDialog(
                                                                                            content: Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Text('Do you want to report this users?', style: GoogleFonts.aBeeZee(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).secondaryHeaderColor)),
                                                                                            ),
                                                                                            title: Text('Are you sure?', style: GoogleFonts.aBeeZee(fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).backgroundColor)),
                                                                                            continueCallBack: () {
                                                                                              context.read<MembersCubit>().updateReported(args.email!, reported = !reported).then((_) {
                                                                                                Navigator.of(context).pop();
                                                                                              });
                                                                                            },
                                                                                            stopCallBack: () {
                                                                                              Navigator.of(context).pop();
                                                                                            });
                                                                                      }));
                                                                                },
                                                                                child: ListTile(leading: Icon(Icons.report, color: Theme.of(context).primaryColor, size: 30), title: peopleState.people[index].reported == false ? Text('Report', style: GoogleFonts.aBeeZee(fontSize: 30, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor)) : Text('Reported', style: GoogleFonts.aBeeZee(fontSize: 30, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor)))),
                                                                            InkWell(
                                                                                onTap: () {
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: (context) {
                                                                                        return MessageDialog(
                                                                                            content: Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Text('Do you want to block this member?', style: GoogleFonts.aBeeZee(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).secondaryHeaderColor)),
                                                                                            ),
                                                                                            title: Text('Are you sure',
                                                                                                style: GoogleFonts.aBeeZee(
                                                                                                  fontSize: 18,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  color: Theme.of(context).backgroundColor,
                                                                                                )),
                                                                                            continueCallBack: () {
                                                                                              context.read<MembersCubit>().updateBlocked(args.email!, blocked = !blocked).then((_) {
                                                                                                Navigator.of(context).pop();
                                                                                              });
                                                                                            },
                                                                                            stopCallBack: () {
                                                                                              Navigator.of(context).pop();
                                                                                            });
                                                                                      });
                                                                                },
                                                                                child: ListTile(leading: Icon(Icons.block, color: Theme.of(context).primaryColor, size: 30), title: Text('Block', style: GoogleFonts.aBeeZee(fontSize: 30, fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor)))),
                                                                            const SizedBox(height: 30),
                                                                            Column(children: [
                                                                              ElevatedButton(
                                                                                  onPressed: () {
                                                                                    print('cancel');
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonDark, padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), textStyle: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 20, fontWeight: FontWeight.bold)),
                                                                                  child: const Text('Cancel'))
                                                                            ])
                                                                          ],
                                                                          colors: const [
                                                                            AppColors.profileDark,
                                                                            AppColors.profileLight
                                                                          ],
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment
                                                                              .bottomLeft,
                                                                          height:
                                                                              250,
                                                                        );
                                                                      },
                                                                      context:
                                                                          context);
                                                                },
                                                                child: ClipRRect(
                                                                    borderRadius: BorderRadius.circular(12),
                                                                    child: Container(
                                                                        width: 50.0,
                                                                        height: 50.0,
                                                                        decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.1),
                                                                          borderRadius:
                                                                              const BorderRadius.all(Radius.circular(12.0)),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                        child: const CustomIcon(icon: FontAwesomeIcons.ellipsisVertical, size: 25, color: AppColors.iconLight))))
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }
                                                return const Text(
                                                    'Something went wrong...');
                                              });
                                        }
                                        return const Text(
                                            'Something went wrong');
                                      },
                                    )
                                  ]))
                        ]),
                    const SizedBox(height: 10),
                    const TitleWithIcon(
                        title: 'Bio', icon: FontAwesomeIcons.solidHeart),
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
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TitleWithIcon(
                        title: 'Pictures', icon: FontAwesomeIcons.images),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 300,
                        child: ListView.separated(
                          itemCount: state.user.imageUrls!.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 20);
                          },
                          itemBuilder: ((context, index) {
                            return Image.network(
                              state.user.imageUrls![index],
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            );
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TitleWithIcon(
                        title: 'Interests', icon: FontAwesomeIcons.list),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
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
                      ),
                    )
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
}
