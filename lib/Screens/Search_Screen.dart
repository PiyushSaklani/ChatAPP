import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Chat_Screen.dart';
import 'package:flutter_application_1/Constants/Constants.dart';
import 'package:flutter_application_1/Widgets/User_model.dart';

class SearchScreen extends StatefulWidget {
  UserModel user;
  SearchScreen({required this.user});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _search = TextEditingController();
  List<Map> _searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      _searchResult = [];
      isLoading = true;
    });
    log("1");
    await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: _search.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No User Found"),
          ),
        );
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Found"),
          ),
        );
      }
      log("2");
      for (var user in value.docs) {
        if (user.data()["email"] != widget.user.email) {
          _searchResult.add(user.data());
        }
      }
      setState(() {
        isLoading = false;
      });
    });
    log("3");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Screen"),
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
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 10, bottom: 10),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      log("Enterd");
                      onSearch();
                      log("Exit 😍");
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    margin: const EdgeInsets.only(right: 20, bottom: 10),
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search....",
                        hintStyle: TextStyle(
                            fontSize: 16,
                            color: kSecondaryColor.withOpacity(.7)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_searchResult.isNotEmpty)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 10, right: 10),
                itemCount: _searchResult.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
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
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            _searchResult[index]["image"],
                          ),
                        ),
                      ),
                      title: Text(
                        _searchResult[index]["name"],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kPrimaryColor.withOpacity(.9)),
                      ),
                      subtitle: Text(
                        _searchResult[index]["email"],
                        style:
                            TextStyle(color: kSecondaryColor.withOpacity(.5)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          log("Goin to ChatScreen👍🏻");
                          setState(() {
                            _search.text = "";
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  friendId: _searchResult[index]["uid"],
                                  friendImage: _searchResult[index]["image"],
                                  friendName: _searchResult[index]["name"],
                                  user: widget.user),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.message,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
              ),
            )
          else if (isLoading == true)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
