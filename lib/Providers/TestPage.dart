import 'package:flutter/material.dart';
import 'package:flutter_application_1/Providers/User_Provider.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.watch<USERS>().userAbout),
            TextButton(
                onPressed: () {
                  context.read<USERS>().getUserinfo();
                },
                child: const Text("Get Data"))
          ],
        ),
      ),
    );
  }
}
