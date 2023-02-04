import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:social/widgets/custombtn.dart';
import 'package:social/widgets/header.dart';
import 'package:social/widgets/image_container.dart';

import '../../config/database/database_repository.dart';
import '../image/bloc/image_bloc.dart';
import '../repositories.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;

  const Pictures({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.8;

    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: SizedBox(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('STEP 3 OF 5',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Theme.of(context).backgroundColor,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 7),
                      ],
                    ),
                    CustomTextHeader(text: 'Add your picture(s)', fontSize: 16),
                    const SizedBox(height: 20),
                    const CustomImageContainer(),
                    const SizedBox(height: 50),
                    Text('You added the pictures: ',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 40),
                    BlocBuilder<ImageBloc, ImageState>(
                      builder: (context, state) {
                        if (state is ImagesLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is ImagesLoaded) {
                          return SizedBox(
                            height: 120,
                            child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(width: 20);
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: state.imageUrls.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Stack(
                                  children: [
                                    Image.network(state.imageUrls[index],
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.fill),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, left: 70.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.delete_rounded,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              size: 28,
                                            ),
                                            onPressed: () async {
                                              print('delete pressed');
                                              await DatabaseRepository()
                                                  .getImages()
                                                  .then(
                                                (value) async {
                                                  var url =
                                                      value!.elementAt(index);

                                                  await StorageRepository()
                                                      .deleteImage(url);
                                                  BlocProvider.of<ImageBloc>(
                                                          context)
                                                      .add(DeleteImage(
                                                          url: url));
                                                },
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        }
                        return const Text('Something went wrong...');
                      },
                    )
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 5,
                      currentStep: 3,
                      selectedColor: Theme.of(context).backgroundColor,
                      unselectedColor: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                        tabController: tabController, text: 'NEXT STEP'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
