import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_time_chart/real_time_chart.dart';

import '../theme/background_clip.dart';
import '../theme/variables.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final stream = positiveDataStream();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                children : [
                  ClipPath(
                    clipper: BackgroundWaveClipper(),
                    child:Container(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [ MidnightBlue , MidnightBlue],
                            )),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15,30,0,30),
                          child: const Text("Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 32,
                            ),
                          ),
                        )
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 40,
                    left: MediaQuery.of(context).padding.left + 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Welcome back Aravind!",
                        //_dateString ?? "Loading",
                        style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 100,
                    left: MediaQuery.of(context).padding.left + 140,
                    child: Container(
                      child: Text(
                        "Air quality score",
                        style: TextStyle(
                            color: white
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 110,
                    left: MediaQuery.of(context).padding.left + 130,
                    child: Container(
                      child: Text(
                        "83%",
                        style: TextStyle(
                          color: white,
                          fontSize: 70,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 210,
                    left: MediaQuery.of(context).padding.left + 125,
                    child: Row(
                      children: [
                        Text(
                          "Quality : ",
                          style: TextStyle(
                            color: white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "GOOD",
                          style: TextStyle(
                            color: Colors.lightGreenAccent,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 260,
                    left: MediaQuery.of(context).padding.left + 95,
                    child: ElevatedButton(
                      onPressed: (){},
                      child: Text(
                        "Generate detailed report",
                        style: TextStyle(
                            color: MidnightBlue
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(TiffanyBlue),
                        elevation: MaterialStateProperty.all(0),
                      ),
                    ),
                  )
                  // Center(
                  //   child: Text(_timeString ?? "Loading", style: TextStyle(fontSize: 24)),
                  // ),
                ]
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RealTimeGraph(
                  stream: stream,
                ),
              ),
            ),
          ]
      ),
    );
  }
}
Stream<double> positiveDataStream() {
  return Stream.periodic(const Duration(milliseconds: 500), (_) {
    return Random().nextInt(300).toDouble();
  }).asBroadcastStream();
}
