import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  String? imageUrl;
  String? age;
  List? interests;
  var currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc((FirebaseAuth.instance.currentUser!.email))
        .get();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<void> deleteUser(id) async {
    await FirebaseFirestore.instance.collection('likeduser').doc(id).delete();
  }
}
