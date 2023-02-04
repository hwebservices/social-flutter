import 'package:image_picker/image_picker.dart';

abstract class BaseStroageRepository {
  Future<void> uploadImage(XFile image);
  Future<String> getImageUrl(String imageName);
  Future<void> deleteImage(String url);
}
