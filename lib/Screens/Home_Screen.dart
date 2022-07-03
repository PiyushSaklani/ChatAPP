import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Providers/User_Provider.dart';
import 'package:flutter_application_1/Screens/Menu_Screen.dart';
import 'package:flutter_application_1/Screens/Chat_Screen.dart';
import 'package:flutter_application_1/Constants/Constants.dart';
import 'package:flutter_application_1/Screens/Search_Screen.dart';
import 'package:flutter_application_1/Widgets/Encryption.dart';
import 'package:flutter_application_1/Widgets/User_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  UserModel user;
  HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        shadowColor: kSecondaryColor.withOpacity(.1),
        leading: IconButton(
          onPressed: () async {
            // await GoogleSignIn().signOut();
            // await FirebaseAuth.instance.signOut();
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => LoginScreen()),
            //     (route) => false);
            context.read<USERS>().getUserinfo();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MenuScreen(
                          user: user,
                        )));
            context.read<USERS>().getUserinfo();
          },
          icon: Container(
            alignment: Alignment.center,
            // margin: const EdgeInsets.only(right: 10),
            height: 30,
            width: 30,
            child: const Icon(
              Icons.menu,
              size: 34,
              color: Colors.white,
            ),
            // child: Image(
            //   image: AssetImage("assets/images/menu.png"),
            // ),
          ),
          // icon: const Icon(
          //   Icons.logout,
          //   color: Colors.white,
          // ),
        ),

        // title: const Text("Home Screen"),
        actions: [
          Container(
            padding: const EdgeInsets.all(7),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(user.image),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ZoomDrawer(
          //     menuScreen: const MenuScreen(),
          //     mainScreen: HomeScreen(user: user)),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(user: user),
                ),
              );
            },
            child: SizedBox(
              // margin: const EdgeInsets.only(left: 20, right: 20),
              width: size.width,
              height: 50,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.circular(50),
              //   // border: Border.all(width: 1.5, color: kSecondaryColor),
              //   boxShadow: [
              //     BoxShadow(
              //       color: kSecondaryColor.withOpacity(.1),
              //       spreadRadius: 5,
              //       blurRadius: 10,
              //       offset: const Offset(0, 3), // changes position of shadow
              //     ),
              //   ],
              // ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: kSecondaryColor.withOpacity(.9),
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(width: 1.5, color: kSecondaryColor),
                      boxShadow: [
                        BoxShadow(
                          color: kSecondaryColor.withOpacity(.3),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                      child: const Icon(
                        Icons.search,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    margin: const EdgeInsets.only(right: 20),
                    height: 50,
                    width: size.width / 1.33,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(width: 1.5, color: kSecondaryColor),
                      boxShadow: [
                        BoxShadow(
                          color: kSecondaryColor.withOpacity(.1),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      "Search....",
                      style: TextStyle(
                          fontSize: 16, color: kSecondaryColor.withOpacity(.5)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: size.height / 1.38283,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .collection("messages")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text("No Chat Available"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (contex, index) {
                          var friendId = snapshot.data.docs[index].id;
                          var lastMsg = EncryptionDecryption.decryptedAES(
                              snapshot.data.docs[index]["last_message"]);
                          return FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(friendId)
                                  .get(),
                              builder: (context, AsyncSnapshot asyncsnapshot) {
                                if (asyncsnapshot.hasData) {
                                  var friends = asyncsnapshot.data;
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(width: 1.5, color: kSecondaryColor),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              kSecondaryColor.withOpacity(.1),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 15),
                                    child: ListTile(
                                      leading: Container(
                                        margin: const EdgeInsets.all(2),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child:
                                              Image.network(friends["image"]),
                                        ),
                                      ),
                                      title: Text(
                                        friends["name"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color:
                                                kPrimaryColor.withOpacity(.9)),
                                      ),
                                      subtitle: Container(
                                        child: Text(
                                          lastMsg,
                                          style: TextStyle(
                                              color: kSecondaryColor
                                                  .withOpacity(.5)),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (contex) => ChatScreen(
                                              friendId: friends["uid"],
                                              friendImage: friends["image"],
                                              friendName: friends["name"],
                                              user: user,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                return const LinearProgressIndicator();
                              });
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => SearchScreen(user: user),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.search),
      // ),
    );
  }
}






// body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Text(
//               "Welcome to HomeScreen",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   "LogOut",
//                   style: TextStyle(
//                       fontSize: 18, color: Color.fromARGB(255, 192, 13, 0)),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 IconButton(
//                   onPressed: () async {
//                     await GoogleSignIn().signOut();
//                     await FirebaseAuth.instance.signOut();
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginScreen()),
//                         (route) => false);
//                   },
//                   icon: const Icon(
//                     Icons.logout,
//                     color: Color.fromARGB(255, 192, 13, 0),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             FloatingActionButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SearchScreen(user: user),
//                   ),
//                 );
//               },
//               child: const Icon(Icons.search),
//             ),
//           ],
//         ),
//       ),