import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../users/model/user.dart';
import '../model/people.dart';
import 'base_people_repository.dart';

class PeopleRepository extends BasePeopleRepository {
  final FirebaseFirestore _firestore;

  auth.User? user = auth.FirebaseAuth.instance.currentUser;
  PeopleRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> savePeople({
    required String email,
    required String username,
    required String persona,
    required bool hot,
    required bool blocked,
    required bool reported,
    String? reason,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.email)
          .collection('people')
          .add({
        'email': email,
        'username': username,
        'persona': persona,
        'hot': hot,
        'blocked': blocked,
        'reported': reported,
        'reason': reason
      }).then(
        (value) => print(value.id),
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Future<People> searchPeople({required String email}) async {
    var user = auth.FirebaseAuth.instance.currentUser;
    final docs = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('people')
        .where('email', isEqualTo: email)
        .get();

    final docData = docs.docs.map((doc) {
      return People.fromSnapshot(doc);
    });

    var res = docData.firstWhere(
      (element) => element.email == email,
      orElse: () => People(),
    );

    print(res);
    return res;
  }

  @override
  Future<User> getPeople({required String email}) async {
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

  @override
  Future<People> getMember({required String email}) async {
    var user = auth.FirebaseAuth.instance.currentUser;
    final docs = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('people')
        .where('email', isEqualTo: email)
        .get();
    final docData = docs.docs.map((doc) {
      return People.fromSnapshot(doc);
    });
    print(docData);
    return docData.first;
  }

  @override
  Future<List<People>> getHunting() async {
    var user = auth.FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('people')
        .get();
    final docData = querySnapshot.docs.map((doc) {
      return People.fromSnapshot(doc);
    }).toList();
    // print(docData);
    return docData;
  }

  @override
  Future<void> deletePeople({required String email}) async {
    var user = auth.FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('people')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  @override
  Future<void> updateHotMember(
      {required String email, required bool hot}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('people')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.update({'hot': hot}).then(
            (value) => print('Hot field successfully updated!'),
            onError: (e) => print('Error updating document $e'));
      }
    });
  }

  @override
  Future<void> updateBlockedMember(
      {required String email, required bool blocked}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('people')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.update({'blocked': blocked}).then(
            (value) => print('Blocked field successfully updated!'),
            onError: (e) => print('Error updating document $e'));
      }
    });
  }

  @override
  Future<void> updateReportedMember(
      {required String email, required bool reported}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .collection('people')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        doc.reference.update({'reported': reported}).then(
            (value) => print('Reported field successfully updated!'),
            onError: (e) => print('Error updating document $e'));
      }
    });
  }

  @override
  Stream<People?> statusMember({required String email}) {
    var user = auth.FirebaseAuth.instance.currentUser;
    final snap = _firestore
        .collection('users')
        .doc(user!.email)
        .collection('people')
        .where('email', isEqualTo: email)
        .snapshots()
        .map(
      (snappshot) {
        for (var doc in snappshot.docs) {
          return People.fromSnapshot(doc);
        }
      },
    );

    // print(snap);
    return snap;
  }
}
