import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/widgets/appbar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/blocs.dart';
import '../features/cubits.dart';
import '../features/repositories.dart';

class TestingBloc extends StatelessWidget {
  static const String routeName = '/bloc';
  const TestingBloc({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => BlocProvider(
              create: (context) =>
                  MembersCubit(peopleRepository: PeopleRepository()),
              child: const TestingBloc(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Testing Bloc',
      ),
      body: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, peopleState) {
          if (peopleState is PeopleLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (peopleState is PeopleLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Column(
                  children: [
                    Center(
                      child: TextButton(
                        onPressed: () async {
                          context.read<MembersCubit>().listenToMembersChanges(
                              email: 'admin@social.com');
                        },
                        child: Text(
                          'press me',
                          style: GoogleFonts.roboto(
                            fontSize: 40,
                            color: Theme.of(context).backgroundColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<MembersCubit, MembersState>(
                      builder: (context, state) {
                        // if (state is MembersLoading) {
                        //   return const Center(
                        //       child: CircularProgressIndicator());
                        // }
                        if (state is MembersLoaded) {
                          return Text(
                            state.hot.toString(),
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.w500),
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ],
            );
          }
          return Center(
            child: Text(
              'Something went wrong...',
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  color: Theme.of(context).backgroundColor,
                  fontWeight: FontWeight.w500),
            ),
          );
        },
      ),
    );
  }
}
