import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/Constants.dart';
import 'package:flutter_application_1/Widgets/Encryption.dart';

class Msg_Textfield extends StatefulWidget {
  final String currentId;
  final String friendId;
  const Msg_Textfield({required this.currentId, required this.friendId});

  @override
  State<Msg_Textfield> createState() => _Msg_TextfieldState();
}

class _Msg_TextfieldState extends State<Msg_Textfield> {
  final TextEditingController _msg = TextEditingController();
  var msg;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 1),
              margin: const EdgeInsets.only(left: 5, bottom: 15, top: 20),
              height: 50,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                // border: Border.all(width: 1.5, color: kSecondaryColor),
                boxShadow: [
                  BoxShadow(
                    color: kSecondaryColor.withOpacity(.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _msg,
                decoration: InputDecoration(
                  hintText: "Message",
                  hintStyle: TextStyle(
                      fontSize: 16, color: kSecondaryColor.withOpacity(.7)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                log(_msg.text);
                msg = EncryptionDecryption.encryptedAES(_msg.text);
                log(msg);
              });
              String message = msg;
              _msg.clear();
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.currentId)
                  .collection("messages")
                  .doc(widget.friendId)
                  .collection("chats")
                  .add({
                "senderId": widget.currentId,
                "receiverId": widget.friendId,
                "message": message,
                "type": "text",
                "date": DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(widget.currentId)
                    .collection("messages")
                    .doc(widget.friendId)
                    .set({
                  "last_message": message,
                });
              });

              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.friendId)
                  .collection("messages")
                  .doc(widget.currentId)
                  .collection("chats")
                  .add({
                "senderId": widget.currentId,
                "receiverId": widget.friendId,
                "message": message,
                "type": "text",
                "date": DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(widget.friendId)
                    .collection("messages")
                    .doc(widget.currentId)
                    .set({
                  "last_message": message,
                });
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 5, bottom: 15, top: 20),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(.9),
                borderRadius: BorderRadius.circular(50),
                // border: Border.all(width: 1.5, color: kSecondaryColor),
                boxShadow: [
                  BoxShadow(
                    color: kSecondaryColor.withOpacity(.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
