import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/database/database_repository.dart';
import '../../repositories.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final DatabaseRepository _databaseRepository;

  ImageBloc({
    required DatabaseRepository databaseRepository,
    required StorageRepository storageRepository,
  })  : _databaseRepository = databaseRepository,
        super(ImagesLoading()) {
    on<LoadImage>(_onLoadImage);
    on<UpdateUserImages>(_onUpdateUserImages);
    on<DeleteImage>(_onDeleteImage);
  }

  void _onLoadImage(LoadImage event, Emitter<ImageState> emit) async {
    final images = await _databaseRepository.getImages();
    emit(ImagesLoaded(imageUrls: images!));
  }

  void _onUpdateUserImages(
      UpdateUserImages event, Emitter<ImageState> emit) async {
    final img = await _databaseRepository.getImages();
    emit(ImagesLoaded(imageUrls: img!));
  }

  void _onDeleteImage(DeleteImage event, Emitter<ImageState> emit) async {
    final img = await _databaseRepository.getImages();
    emit(ImagesLoaded(imageUrls: img!));
  }
}
