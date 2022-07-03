import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/Constants.dart';
import 'package:flutter_application_1/Widgets/Msg_Textfield.dart';
import 'package:flutter_application_1/Widgets/Single_message.dart';
import 'package:flutter_application_1/Widgets/User_model.dart';

class ChatScreen extends StatelessWidget {
  final UserModel user;
  final String friendId;
  final String friendName;
  final String friendImage;

  const ChatScreen(
      {required this.friendId,
      required this.friendImage,
      required this.friendName,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        shadowColor: kSecondaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 36,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(friendName),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                friendImage,
                height: 40,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(user.uid)
                    .collection("messages")
                    .doc(friendId)
                    .collection("chats")
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text("➶"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe =
                              snapshot.data.docs[index]["senderId"] == user.uid;
                          return Singlemessage(
                              isMe: isMe,
                              message: snapshot.data.docs[index]["message"]);
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          Msg_Textfield(currentId: user.uid, friendId: friendId)
        ],
      ),
    );
  }
}
