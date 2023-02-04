import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;
  Future<void> signOut();
  Future<auth.User?> singIn({
    required String email,
    required String password,
  });
}
