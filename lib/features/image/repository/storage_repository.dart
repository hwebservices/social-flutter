import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../config/database/database_repository.dart';
import '../../repositories.dart';

class StorageRepository extends BaseStroageRepository {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(XFile image) async {
    try {
      await storage
          .ref(_auth.currentUser!.email)
          .child(image.name)
          .putFile(File(image.path))
          .then((p0) => DatabaseRepository().updateUserPictures(image.name));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String> getImageUrl(String imageName) async {
    String downloadUrl = await storage
        .ref('${_auth.currentUser!.email}/$imageName')
        .getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<void> deleteImage(String url) async {
    await storage.refFromURL(url).delete().then((_) async {
      final docs = _firestore.collection('users').doc(_auth.currentUser!.email);
      // print(url);
      docs.update({
        'imageUrl': FieldValue.arrayRemove([url])
      });
    });
    print('deleted from storage');
  }
}
