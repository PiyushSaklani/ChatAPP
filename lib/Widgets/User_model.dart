import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String name;
  String image;
  Timestamp date;
  String uid;
  String nickname;
  String dob;
  String gender;
  String about;

  UserModel(
      {required this.date,
      required this.email,
      required this.image,
      required this.name,
      required this.uid,
      required this.about,
      required this.dob,
      required this.gender,
      required this.nickname});

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
        date: snapshot["date"],
        email: snapshot["email"],
        image: snapshot["image"],
        name: snapshot["name"],
        uid: snapshot["uid"],
        nickname: snapshot["nickname"],
        dob: snapshot["dob"],
        gender: snapshot["gender"],
        about: snapshot["about"]);
  }
}
