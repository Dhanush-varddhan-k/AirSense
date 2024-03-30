import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white54,
            ),
          ),
          backgroundColor: Colors.blueAccent,
          automaticallyImplyLeading: false,
        ),
        body: Text(
          "HELLO"
        ),
      ),
    );
  }
}
