import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/Constants.dart';
import 'package:flutter_application_1/Providers/User_Provider.dart';
import 'package:flutter_application_1/Widgets/User_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  UserModel user;
  ProfileScreen({required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _about = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  late String newAbout = "";
  late String _user;
  // final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc("1nOwfs4gsGeSOoxg7tipZQnTH7C3")
  //     .snapshots();

  // getResult() {
  //   FirebaseAuth.instance.authStateChanges().listen(
  //     (User? user) {
  //       if (user != null) {
  //         log(user.uid);
  //         _user = user.uid;
  //       }
  //     },
  //   );
  //   CollectionReference users = FirebaseFirestore.instance.collection("users");
  //   users.doc(_user).snapshots().listen((result) {
  //     log(result.get("about"));
  //     var name = result.get("about");
  //     return name;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // UserModel UM = UserModel.fromJson(FirebaseFirestore.instance
    //   .collection("users")
    //   .doc(FirebaseAuth.instance.currentUser!.uid)
    //   .get() as DocumentSnapshot<Object?>);
    // String About = widget.user.about;
    final size = MediaQuery.of(context).size;
    // var name2 = getResult();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: kSecondaryColor,
                width: size.width,
                height: 10,
              ),
              SizedBox(
                height: size.width / 1.3,
                child: Stack(
                  // alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      height: size.width,
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(300),
                            bottomRight: Radius.circular(300)),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      height: size.width / 2,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(widget.user.image),
                              fit: BoxFit.fitHeight)),
                    ),
                    Container(
                      margin:
                          EdgeInsets.fromLTRB(120, size.width / 1.9, 240, 20),
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(.2),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.create_outlined,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 60,
                width: 350,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5, color: kPrimaryColor.withOpacity(.2)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        context.watch<USERS>().userNickname,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 3, 0, 40),
                      height: 20,
                      color: Colors.white,
                      child: Text(
                        " Nickname ",
                        style: TextStyle(
                            color: kPrimaryColor.withOpacity(.7),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 300),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("About"),
                              content: TextFormField(
                                controller: _nickname,
                                decoration: InputDecoration(
                                    hintText: widget.user.about),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {

await FirebaseFirestore.instance
                      .collection("users")
                      .where("nickname", isEqualTo: _nickname.text)
                      .get()
                      .then((value) async {
                    if (value.docs.isEmpty) {
                      FirebaseAuth.instance
                                          .authStateChanges()
                                          .listen(
                                        (User? user) {
                                          if (user != null) {
                                            log(user.uid);
                                            _user = user.uid;
                                          }
                                        },
                                      );
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(_user)
                                          .update({
                                        "nickname": _nickname.text,
                                      });
                                      context.read<USERS>().getUserinfo();
                                      Navigator.pop(context);
                    }else{ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nickname already taken."),
                        ),
                      );}});






                                      




                                    },
                                    child: const Text("Save"))
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.create_outlined,
                          color: kPrimaryColor.withOpacity(.8),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 350,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5, color: kPrimaryColor.withOpacity(.2)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        widget.user.name,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 3, 0, 40),
                      height: 20,
                      color: Colors.white,
                      child: Text(
                        " Name ",
                        style: TextStyle(
                            color: kPrimaryColor.withOpacity(.7),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 300),
                    //   child: IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.create_outlined,
                    //       color: kPrimaryColor.withOpacity(.8),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 350,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5, color: kPrimaryColor.withOpacity(.2)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        widget.user.email,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 3, 0, 40),
                      height: 20,
                      color: Colors.white,
                      child: Text(
                        " Email ",
                        style: TextStyle(
                            color: kPrimaryColor.withOpacity(.7),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Container(
                    //   margin: const EdgeInsets.only(left: 300),
                    //   child: IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.create_outlined,
                    //       color: kPrimaryColor.withOpacity(.8),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 170,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5,
                                color: kPrimaryColor.withOpacity(.2)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            widget.user.dob,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 3, 0, 40),
                          height: 20,
                          color: Colors.white,
                          child: Text(
                            " DOB ",
                            style: TextStyle(
                                color: kPrimaryColor.withOpacity(.7),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(left: 120),
                        //   child: IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(
                        //       Icons.create_outlined,
                        //       color: kPrimaryColor.withOpacity(.8),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 60,
                    width: 170,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5,
                                color: kPrimaryColor.withOpacity(.2)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            widget.user.gender,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 3, 0, 40),
                          height: 20,
                          color: Colors.white,
                          child: Text(
                            " Gender ",
                            style: TextStyle(
                                color: kPrimaryColor.withOpacity(.7),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(left: 120),
                        //   child: IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(
                        //       Icons.create_outlined,
                        //       color: kPrimaryColor.withOpacity(.8),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: 350,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20, right: 50),
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.5, color: kPrimaryColor.withOpacity(.2)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        context.watch<USERS>().userAbout,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(30, 3, 0, 40),
                      height: 20,
                      color: Colors.white,
                      child: Text(
                        " About ",
                        style: TextStyle(
                            color: kPrimaryColor.withOpacity(.7),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 300),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("About"),
                              content: TextFormField(
                                controller: _about,
                                decoration: InputDecoration(
                                    hintText: widget.user.about),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      FirebaseAuth.instance
                                          .authStateChanges()
                                          .listen(
                                        (User? user) {
                                          if (user != null) {
                                            log(user.uid);
                                            _user = user.uid;
                                          }
                                        },
                                      );
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(_user)
                                          .update({
                                        "about": _about.text,
                                      });
                                      context.read<USERS>().getUserinfo();
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Save"))
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.create_outlined,
                          color: kPrimaryColor.withOpacity(.8),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
