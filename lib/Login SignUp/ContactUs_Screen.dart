import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/Constants.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 350),
                width: size.width,
                height: size.width / 4,
                decoration: const BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(1000),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 16, left: 30, right: 30, bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        "Hello.",
                        style: TextStyle(
                            fontSize: 44, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "125 Nichols Rd",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Toronto, ON",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("B8E 7C6",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                        const SizedBox(
                          width: 100,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text("(986)233-9220",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("chatapp@gmail.com",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("chatapp.com",
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const TextField(),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Phone",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const TextField(),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Email",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const TextField(),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Anything else you'd like us to know?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    const TextField(),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 240, top: 22, bottom: 22, right: 40),
                width: size.width,
                height: size.width / 4,
                decoration: const BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(1000))),
                child: SizedBox(
                  height: 50,
                  width: 100,
                  // decoration: BoxDecoration(
                  //     border: Border.all(width: 0, color: Colors.white),
                  //     borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
