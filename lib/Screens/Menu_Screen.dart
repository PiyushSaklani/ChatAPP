import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/Constants.dart';
import 'package:flutter_application_1/Login%20SignUp/ContactUs_Screen.dart';
import 'package:flutter_application_1/Screens/Profile_Screen.dart';
import 'package:flutter_application_1/Widgets/User_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../Login SignUp/Login_Screen.dart';
import '../Providers/User_Provider.dart';

class MenuScreen extends StatelessWidget {
  UserModel user;
  MenuScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [kPrimaryColor, kSecondaryColor])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.black,
                              border: Border.all(
                                  width: 1.5,
                                  color: Colors.white.withOpacity(.6))),
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(user.image),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      user.nickname,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(1)),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      user.email,
                      style: TextStyle(
                          fontSize: 14, color: Colors.white.withOpacity(.8)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "App",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(1)),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(
                  thickness: 1,
                  color: Colors.white.withOpacity(.3),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leading: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Dashboard",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                              user: user,
                            ),
                          ),
                        );
                      },
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "My Profile",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    // ListTile(
                    //   onTap: () {},
                    //   leading: const Icon(Icons.settings),
                    //   title: const Text("Setting"),
                    // ),
                    ListTile(
                      onTap: () {
                        context.read<USERS>().userId();
                        context.read<USERS>().getUserinfo();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactUsScreen()));
                      },
                      leading: const Icon(
                        Icons.contact_page,
                        color: Colors.white,
                      ),
                      title: const Text(
                        "Contact Us",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "Setting",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(
                  thickness: 1,
                  color: Colors.white.withOpacity(.3),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  children: [
                    ListTile(
                      title: const Text(
                        "Dark Mode",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Switch between Lightmode and Darkmode.",
                        style: TextStyle(color: Colors.white.withOpacity(.7)),
                      ),
                      trailing: const Icon(
                        Icons.sunny,
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        "Change Password",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "Reset your password.",
                        style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.key_outlined,
                        color: Colors.white,
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        await GoogleSignIn().signOut();
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      },
                      title: const Text(
                        "LogOut",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        "SignIn with other account.",
                        style: TextStyle(color: Colors.white.withOpacity(.7)),
                      ),
                      trailing: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
