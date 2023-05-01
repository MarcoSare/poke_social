import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? profilePicture;

  UserModel({this.firstName, this.lastName, this.email, this.profilePicture});
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        firstName: map['firstName'],
        lastName: map['lastName'],
        email: map['email'],
        profilePicture: map['profilePicture']);
  }
}
