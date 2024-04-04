import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/background_clip.dart';
import '../theme/variables.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: BackgroundWaveClipper(),
                  child:Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [ MidnightBlue , MidnightBlue],
                      )),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 40,
                  left: MediaQuery.of(context).padding.left + 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your current rank : ",
                      //_dateString ?? "Loading",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
