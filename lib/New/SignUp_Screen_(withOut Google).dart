import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/New/Update_Profile_Detail.dart';
import 'package:flutter_application_1/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Constants/Constants.dart';

class SignUpScreen_ extends StatefulWidget {
  @override
  State<SignUpScreen_> createState() => _SignUpScreen_State();
}

class _SignUpScreen_State extends State<SignUpScreen_> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  late String _user;

//! Google SignIn
  Future signInbyGOOGLE() async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return log("NO");
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist = await _firestore
        .collection("users")
        .doc(userCredential.user!.uid)
        .get();

    if (userExist.exists) {
      log("User already exists!😊");
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
      // log(_firestore.collection("users").doc("name").get().toString());
    } else {
      // await _firestore.collection("users").doc(userCredential.user!.uid).set({
      //   "name": userCredential.user!.displayName,
      //   "email": userCredential.user!.email,
      //   "image": userCredential.user!.photoURL,
      //   "uid": userCredential.user!.uid,
      //   "date": DateTime.now(),
      // });
    }
    
    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProfileScreen()));
    
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.width,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/B2_1.png"),
                      fit: BoxFit.cover),
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width / 4.87714,
                          bottom: size.height / 18.85285),
                      child: const Text(
                        "Create",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: size.width / 4.87714, top: size.height / 40),
                      child: const Text(
                        "Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 34,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: size.height / 13.82834,
              //   width: size.width / 1.17548,
              //   child: TextFormField(
              //     cursorColor: kSecondaryColor,
              //     controller: _name,
              //     decoration: const InputDecoration(
              //       focusColor: kSecondaryColor,
              //       labelStyle: TextStyle(color: kSecondaryColor),
              //       labelText: "Name",
              //       prefixIcon: Icon(
              //         Icons.person,
              //         color: kSecondaryColor,
              //       ),
              //       prefixIconColor: kSecondaryColor,
              //       hintText: "Name",
              //       hintStyle: TextStyle(color: Colors.grey),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: size.height / 82.97,
              // ),
              // SizedBox(
              //   height: size.height / 13.82834,
              //   width: size.width / 1.17548,
              //   child: TextFormField(
              //     cursorColor: kSecondaryColor,
              //     controller: _nickname,
              //     decoration: const InputDecoration(
              //       focusColor: kSecondaryColor,
              //       labelStyle: TextStyle(color: kSecondaryColor),
              //       labelText: "Nickname",
              //       prefixIcon: Icon(
              //         Icons.face,
              //         color: kSecondaryColor,
              //       ),
              //       prefixIconColor: kSecondaryColor,
              //       hintText: "Nikename",
              //       hintStyle: TextStyle(color: Colors.grey),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: size.height / 82.97,
              // ),
              SizedBox(
                height: size.height / 13.82834,
                width: size.width / 1.17548,
                child: TextFormField(
                  cursorColor: kSecondaryColor,
                  controller: _email,
                  decoration: const InputDecoration(
                    focusColor: kSecondaryColor,
                    labelStyle: TextStyle(color: kSecondaryColor),
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.mail,
                      color: kSecondaryColor,
                    ),
                    prefixIconColor: kSecondaryColor,
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 82.97,
              ),
              SizedBox(
                height: size.height / 13.82834,
                width: size.width / 1.17548,
                child: TextFormField(
                  cursorColor: kSecondaryColor,
                  obscureText: true,
                  controller: _password,
                  decoration: const InputDecoration(
                    focusColor: kSecondaryColor,
                    labelStyle: TextStyle(color: kSecondaryColor),
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.key,
                      color: kSecondaryColor,
                    ),
                    prefixIconColor: kSecondaryColor,
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20.7425,
              ),
              //! new
              GestureDetector(
                onTap: () async {
                  //? Google SignUp
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: _email.text, password: _password.text);

                  // FirebaseAuth.instance.authStateChanges().listen(
                  //   (User? user) {
                  //     if (user != null) {
                  //       log(user.uid);
                  //     }
                  //   },
                  // );
                  //?
                  // await FirebaseFirestore.instance
                  //     .collection("users")
                  //     .where("nickname", isEqualTo: _nickname.text)
                  //     .get()
                  //     .then((value) async {
                  //   if (value.docs.isEmpty) {
                  //     await FirebaseAuth.instance
                  //         .createUserWithEmailAndPassword(
                  //             email: _email.text, password: _password.text);
                  //     FirebaseAuth.instance.authStateChanges().listen(
                  //       (User? user) {
                  //         if (user != null) {
                  //           log(user.uid);
                  //           _user = user.uid;
                  //         }
                  //       },
                  //     );
                  //     await FirebaseFirestore.instance
                  //         .collection("users")
                  //         .doc(_user)
                  //         .set({
                  //       "name": _name.text,
                  //       "email": _email.text,
                  //       "uid": _user,
                  //       "date": DateTime.now(),
                  //       "nickname": _nickname.text,
                  //       "image":
                  //           "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=",
                  //     });
                  //     log("work done");
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => MyApp()));
                  //     return;
                  //   } else {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Text("Nickname already taken."),
                  //       ),
                  //     );
                  //   }
                  // });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProfileScreen()));
                },
                child: Container(
                  height: size.height / 14,
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kSecondaryColor),
                  alignment: Alignment.center,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 55.31334,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20, left: 30),
                      height: 1,
                      width: size.width / 3.425,
                      color: Colors.grey,
                    ),
                    const Text("Or"),
                    Container(
                      margin: const EdgeInsets.only(right: 30, left: 20),
                      height: 1,
                      width: size.width / 3.425,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 55.31334,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: size.height / 14,
                  width: size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1.5, color: kSecondaryColor),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor,
                        fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 82.94,
              ),
              ElevatedButton(
                onPressed: () async {
                  log("Button Pressed");
                  await signInbyGOOGLE();
                  log("Work Done!😍");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:
                          const BorderSide(color: kSecondaryColor, width: 1.5),
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  height: size.height / 14,
                  width: size.width / 1.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                          "https://www.freepnglogos.com/uploads/google-logo-png/file-google-logo-svg-wikimedia-commons-23.png")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 21.47,
              ),
              //! old
              // ElevatedButton(
              //   onPressed: () async {
              //     log("Button Pressed");
              //     await signInbyGOOGLE();
              //     log("Work Done!😍");
              //   },
              //   style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.all(Colors.black)),
              //   child: Container(
              //     padding: const EdgeInsets.all(10),
              //     height: 50,
              //     width: 200,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Image.network(
              //             "https://www.freepnglogos.com/uploads/google-logo-png/file-google-logo-svg-wikimedia-commons-23.png")
              //       ],
              //     ),
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () => Navigator.pop(context),
              //   child: const Text("Login"),
              // ),
              // GestureDetector(
              //   onTap: () async {
              //     await FirebaseFirestore.instance
              //         .collection("users")
              //         .where("nickname", isEqualTo: _nickname.text)
              //         .get()
              //         .then((value) async {
              //       if (value.docs.isEmpty) {
              //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
              //             email: _email.text, password: _password.text);
              //         FirebaseAuth.instance.authStateChanges().listen(
              //           (User? user) {
              //             if (user != null) {
              //               log(user.uid);
              //               _user = user.uid;
              //             }
              //           },
              //         );
              //         await FirebaseFirestore.instance
              //             .collection("users")
              //             .doc(_user)
              //             .set({
              //           "name": _name.text,
              //           "email": _email.text,
              //           "uid": _user,
              //           "date": DateTime.now(),
              //           "nickname": _nickname.text,
              //           "image":
              //               "https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=",
              //         });
              //         log("work done");
              //         Navigator.push(context,
              //             MaterialPageRoute(builder: (context) => MyApp()));
              //         return;
              //       } else {
              //         ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(
              //             content: Text("Nickname already taken."),
              //           ),
              //         );
              //       }
              //     });
              //   },
              //   child: Container(
              //     height: size.height / 14,
              //     width: size.width / 1.2,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         color: Colors.blue),
              //     alignment: Alignment.center,
              //     child: const Text("SignUp"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
