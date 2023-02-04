import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../repositories.dart';
import '../model/user.dart';

class UsersRepository extends BaseUsersRepo {
  final FirebaseFirestore _firestore;

  UsersRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<User> getUsers({required String email}) async {
    final docs = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    final docData = docs.docs.map((doc) {
      return User.fromSnapshot(doc);
    });
    final res = docData.where((element) => element.email == email);
    print(res);
    return res.first;
  }
}
