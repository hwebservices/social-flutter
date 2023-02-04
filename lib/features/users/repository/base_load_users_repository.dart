import '../model/user.dart';

abstract class BaseUsersRepo {
  // Stream<User> getUser({required String email});
  Future<User> getUsers({required String email});
}
