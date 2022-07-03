import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/Constants.dart';
import 'package:flutter_application_1/Widgets/Encryption.dart';

class Singlemessage extends StatelessWidget {
  final String message;
  final bool isMe;
  const Singlemessage({required this.isMe, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          margin: const EdgeInsets.fromLTRB(16, 6, 16, 0),
          constraints: const BoxConstraints(maxWidth: 260),
          decoration: BoxDecoration(
            color: isMe
                ? kSecondaryColor.withOpacity(.9)
                : kSecondaryColor.withOpacity(.12),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            EncryptionDecryption.decryptedAES(message),
            style: TextStyle(
                color: isMe ? Colors.white : Colors.black87, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
