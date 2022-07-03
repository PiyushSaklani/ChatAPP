import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'User_model.dart';

class ZoomDra extends StatefulWidget {
  const ZoomDra({Key? key}) : super(key: key);

  @override
  State<ZoomDra> createState() => _ZoomDraState();
}

class _ZoomDraState extends State<ZoomDra> {
  Future<UserModel> userSignedInchecker() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();
    UserModel userModel = UserModel.fromJson(userData);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
