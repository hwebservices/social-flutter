import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  String? id;
  String? name;
  String? age;
  String? email;
  List<dynamic>? interests;
  List<dynamic>? imageUrls;
  String? bio;
  String? interestedIn;
  String? profilePicture;
  String? coverPicture;
  String? gender;
  String? location;
  GeoPoint? geopoint;
  String? password;

  User(
      {this.id,
      this.name,
      this.age,
      this.email,
      this.interests,
      this.imageUrls,
      this.interestedIn,
      this.bio,
      this.gender,
      this.profilePicture,
      this.geopoint,
      this.coverPicture,
      this.location,
      this.password});

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        email,
        geopoint,
        interests,
        imageUrls,
        bio,
        gender,
        location,
        password,
      ];
  static User fromSnapshot(DocumentSnapshot snapshot) {
    User user = User(
      id: snapshot.id,
      name: snapshot['username'],
      gender: snapshot['gender'],
      age: snapshot['age'],
      email: snapshot['email'],
      interests: snapshot['interest'],
      imageUrls: snapshot['imageUrl'],
      bio: snapshot['bio'],
      location: snapshot['location'],
      geopoint: snapshot['currentPostion'],
      password: snapshot['password'],
    );
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'imageUrl': imageUrls,
      'interests': interests,
      'bio': bio,
      'location': location,
      'password': password,
    };
  }
}
