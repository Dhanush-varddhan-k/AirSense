import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:real_time_chart/real_time_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../charts/line_chart.dart';
import '../theme/background_clip.dart';
import '../theme/variables.dart';
import '../widgets/chart_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // String _timeString = _formatDateTime(DateTime.now());
  String? _timeString;
  String? _dateString;
  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    _dateString = _formatDate(DateTime.now());
    print("Time : ${_timeString}");
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }
  void _getTime() {
    final String formattedDateTime = _formatDateTime(DateTime.now());
    final String formattedDate = _formatDate(DateTime.now());
    setState(() {
      _timeString = formattedDateTime;
      _dateString = formattedDate;
    });
  }
  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }
  String _formatDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }
  // final List<ChartData> chartData = [
  //   ChartData(2010, 35),
  //   ChartData(2011, 28),
  //   ChartData(2012, 34),
  //   ChartData(2013, 32),
  //   ChartData(2014, 40)
  // ];
  @override
  Widget build(BuildContext context) {
    final stream = positiveDataStream();
    return PopScope(
      canPop: false,
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     'Dashboard',
        //     style: TextStyle(
        //       color: Colors.white54,
        //     ),
        //   ),
        //   centerTitle: true,
        //   backgroundColor: Colors.blueAccent,
        //   automaticallyImplyLeading: false,
        // ),
        body: SingleChildScrollView(
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
        ),
        bottomNavigationBar: Container(
          color: MidnightBlue,
          height: 80,
          child: GNav(
              rippleColor: MidnightBlue, // tab button ripple color when pressed
              hoverColor: BabyBlue, // tab button hover color
              gap: 8, // the tab button gap between icon and text
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.card_membership,
                  text: 'Progress',
                  onPressed: (){
                    Navigator.pushNamed(context, '/progress_page');
                  },
                ),
                GButton(
                  // onPressed: (){
                  //   Navigator.pushNamed(context,'/profile');
                  // },
                  icon: Icons.room_preferences,
                  text: 'Rooms',
                ),
                GButton(
                  // onPressed: (){
                  //   Navigator.pushNamed(context,'/profile');
                  // },
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ]
          ),
        ),

          // body: Container(
          //   color: Color(0xfff0f0f0),
          //   child: ListView(
          //     padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          //     children: <Widget>[
          //       ChartContainer(
          //         title: 'Line Chart',
          //         color: Color.fromRGBO(45, 108, 223, 1),
          //         chart: LineChartContent(),
          //       ),
          //     ],
          //   ),
          // )


          // body: Center(
          //     child: Container(
          //         child: SfCartesianChart(
          //           backgroundColor: Colors.redAccent,
          //           margin: EdgeInsets.fromLTRB(10, 5, 10, 400),
          //             series: <CartesianSeries>[
          //               // Renders line chart
          //               LineSeries<ChartData, int>(
          //                   dataSource: chartData,
          //                   xValueMapper: (ChartData data, _) => data.x,
          //                   yValueMapper: (ChartData data, _) => data.y,
          //                   markerSettings: MarkerSettings(
          //                     height: 50,
          //                     width: 50,
          //                   ),
          //               )
          //             ]
          //         )
          //     )
          // )


      ),
    );
  }
  Stream<double> positiveDataStream() {
    return Stream.periodic(const Duration(milliseconds: 500), (_) {
      return Random().nextInt(300).toDouble();
    }).asBroadcastStream();
  }
}
// class ChartData {
//   ChartData(this.x, this.y);
//   final int x;
//   final double y;
// }

// Random().nextInt(300).toDouble();