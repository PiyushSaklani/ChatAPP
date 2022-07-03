import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class USERS with ChangeNotifier {
  String _userUid = "-";
  String _About = "-";
  String _Nickname = "-";

  String get userUid => _userUid;
  String get userAbout => _About;
  String get userNickname => _Nickname;

  void userId() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _userUid = user.uid;
      }
    });
  }

  void getUserinfo() async {
    if (_userUid == "-") {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          _userUid = user.uid;
        }
      });
    }
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(_userUid)
        .get();

    log("Going on");

    _About = snapshot["about"];
    _Nickname = snapshot["nickname"];
    notifyListeners();
  }
}
