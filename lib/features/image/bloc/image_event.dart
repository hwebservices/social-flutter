part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends ImageEvent {
  final List<dynamic> imageUrls;
  const LoadImage({required this.imageUrls});

  @override
  List<Object> get props => [imageUrls];
}

class UpdateUserImages extends ImageEvent {
  final List<dynamic> image;
  const UpdateUserImages({required this.image});

  @override
  List<Object> get props => [image];
}

class DeleteImage extends ImageEvent {
  final String url;

  const DeleteImage({required this.url});

  @override
  List<Object> get props => [url];
}
