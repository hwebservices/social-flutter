import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../features/repositories.dart';
import '../../features/users/model/user.dart';
import 'base_database_repository.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

  @override
  Stream<User> getUser(String userId) {
    final snap = _firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.email)
        .snapshots()
        .map((snapshot) => User.fromSnapshot(snapshot));

    print(snap);
    return snap;
  }

  @override
  Future<void> updateUserPictures(String imagePath) async {
    String getdownloadUrl = await StorageRepository().getImageUrl(imagePath);
    print(getdownloadUrl);
    return _firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.email)
        .update({
      'imageUrl': FieldValue.arrayUnion([getdownloadUrl])
    });
  }

  @override
  Future<List<dynamic>?> getImages() async {
    return await _firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.email)
        .get()
        .then((value) {
      final map = value.data()!;
      return map['imageUrl'];
    });
  }
}
