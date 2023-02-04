// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImagesLoading extends ImageState {
  @override
  List<Object> get props => [];
}

class ImagesLoaded extends ImageState {
  final List<dynamic> imageUrls;
  const ImagesLoaded({this.imageUrls = const []});

  @override
  List<Object> get props => [imageUrls];
}

class ImagesDeleted extends ImageState {
  @override
  List<Object> get props => [];
}
