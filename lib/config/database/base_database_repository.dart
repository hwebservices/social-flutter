import '../../features/users/model/user.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser(String userId);
  Future<void> updateUserPictures(String imagePath);
  Future<void> getImages();
}
