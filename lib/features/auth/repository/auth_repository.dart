import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  Future<auth.User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      await user!.sendEmailVerification();
      return user;
    } catch (_) {}
    return null;
  }

  @override
  Future<auth.User?> singIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<auth.User?> saveUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.email)
          .set({
        'email': email,
        'password': password,
        'username': username,
      });
    } catch (_) {}
    return null;
  }

  Future<void> updateAge({required String age}) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.email)
          .update({
        'age': age,
      });
    } catch (_) {}
  }

  Future<void> updateGender({required String gender}) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.email)
          .update({
        'gender': gender,
      });
    } catch (_) {}
  }

  Future<void> updateBio({
    required String bio,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.email)
          .update({
        'bio': bio,
      });
    } catch (_) {}
  }

  Future<void> updateInterest({
    required List interest,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.email)
          .update({
        'interest': interest,
      });
    } catch (_) {}
  }

  Future<void> updateLocation(
      {required String location, final GeoPoint? geoPoint}) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_firebaseAuth.currentUser!.email)
          .update({
        'location': location,
        'currentPostion': GeoPoint(geoPoint!.latitude, geoPoint.longitude),
      });
    } catch (_) {}
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
