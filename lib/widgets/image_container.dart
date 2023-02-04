import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/database/database_repository.dart';
import '../features/blocs.dart';
import '../features/repositories.dart';

class CustomImageContainer extends StatefulWidget {
  final String? imageUrl;
  const CustomImageContainer({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  @override
  State<CustomImageContainer> createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: SizedBox(
          height: 120,
          width: 120,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                  width: 100,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight * 1.2,
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 28,
                  ),
                  onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      await StorageRepository().uploadImage(image);
                      print('uplaoding');
                      await DatabaseRepository().getImages().then((value) =>
                          BlocProvider.of<ImageBloc>(context)
                              .add(UpdateUserImages(image: value!)));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
