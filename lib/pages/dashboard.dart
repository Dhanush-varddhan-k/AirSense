import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_time_chart/real_time_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../theme/background_clip.dart';
import '../theme/variables.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late double ppm = 0.0;
  late double co = 0.0;
  late double methane = 0.0;
  late double ammonia = 0.0;
  late double temp = 0.0;
  late double humid = 0.0;

  late final streamData = FirebaseDatabase.instance
      .ref()
      .child('UsersData')
      .child('hpS18ECifIcqyTDPNDw84Cjd5ck2')
      .child('readings')
      .child('air').onValue;

  int selectedIndex = 0;
  late var stream = positiveDataStream(selectedIndex);

  List<String> dropdownItems = [
    'PPM',
    'CO',
    'Methane',
    'Ammonia'
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data?.snapshot.value as Map?;
          if (data == null) {
            return Text(
              'No data',
              style: TextStyle(
                color: white,
                fontSize: 30,
              ),
            );
          }
          ppm = double.parse(data['ppm']);
          co = double.parse(data['co']);
          methane = double.parse(data['methane']);
          ammonia = double.parse(data['ammonia']);
          temp = double.parse(data['temp']);
          humid = double.parse(data['humid']);

          stream = positiveDataStream(selectedIndex);

          print("PPM : $ppm\n");
          print("PPM : $co\n");
          print("PPM : $methane\n");
          print("PPM : $ammonia\n");

          return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                      children: [
                        ClipPath(
                          clipper: BackgroundWaveClipper(),
                          child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 400,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [purple, purple],
                                  )),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(15, 30, 0,
                                    30),
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
                          top: MediaQuery
                              .of(context)
                              .padding
                              .top + 40,
                          left: MediaQuery
                              .of(context)
                              .padding
                              .left + 10,
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
                          top: MediaQuery
                              .of(context)
                              .padding
                              .top + 100,
                          left: MediaQuery
                              .of(context)
                              .padding
                              .left + 140,
                          child: Container(
                            child: Text(
                              "CO2 PPM Score",
                              style: TextStyle(
                                  color: white
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery
                              .of(context)
                              .padding
                              .top + 125,
                          left: MediaQuery
                              .of(context)
                              .padding
                              .left + 120,
                          child: Text(
                              "$ppm",
                              style: TextStyle(
                                color: white,
                                fontSize: 50,
                              ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery
                              .of(context)
                              .padding
                              .top + 205,
                          left: MediaQuery
                              .of(context)
                              .padding
                              .left + 90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Quality : ",
                                style: TextStyle(
                                  color: white,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "MODERATE",
                                style: TextStyle(
                                  color: Colors.limeAccent,
                                  fontSize: 20,
                                ),
                              ),
                              IconButton(
                                  onPressed: (){
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context){
                                          return Container(
                                            height: 800,
                                            child: Center(
                                              child : Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                      "Quality Index",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20
                                                    ),
                                                  ),
                                                  DataTable(
                                                    columns: [
                                                      DataColumn(label: Text(
                                                        'Range(PPM) of CO2',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      )),
                                                      DataColumn(label: Text(
                                                        'Status',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      )),
                                                    ],
                                                    rows: [
                                                      DataRow(cells: [
                                                        DataCell(Text('0-50')),
                                                        DataCell(Text('Good')),
                                                      ]),
                                                      DataRow(cells: [
                                                        DataCell(Text('51-100')),
                                                        DataCell(Text('Moderate')),
                                                      ]),
                                                      DataRow(cells: [
                                                        DataCell(Text('101-200')),
                                                        DataCell(Text('Unhealthy')),
                                                      ]),
                                                      DataRow(cells: [
                                                        DataCell(Text('201-251')),
                                                        DataCell(Text('Very Unhealthy')),
                                                      ]),
                                                      DataRow(cells: [
                                                        DataCell(Text('250>')),
                                                        DataCell(Text('Hazardous')),
                                                      ]),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                  },
                                  icon: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                  )
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: MediaQuery
                              .of(context)
                              .padding
                              .top + 260,
                          left: MediaQuery
                              .of(context)
                              .padding
                              .left + 95,
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    // Modify the container as per your requirement
                                    height: 800,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              "Report",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                              ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          // Text(
                                          //   "Current PPM of CO2 is : $ppm\n"
                                          //    "Current PPM of CO is : $co\n"
                                          //       "Current PPM of Methane is : $methane\n"
                                          //       "Current PPM of Ammonia is : $ammonia\n"
                                          //       "Current Temp is : $temp\n"
                                          //       "Current Humidity is : $humid\n",
                                          //   style: TextStyle(fontSize: 14),
                                          //   textAlign: TextAlign.center,
                                          // ),
                                          DataTable(
                                            columns: [
                                              DataColumn(label: Text(
                                                'Components',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                textAlign: TextAlign.center,
                                              )),
                                              DataColumn(label: Text(
                                                'Value',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(Text('CO2')),
                                                DataCell(Text('$ppm PPM')),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('CO')),
                                                DataCell(Text('$co PPM')),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Methane')),
                                                DataCell(Text('$methane PPM')),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Ammonia')),
                                                DataCell(Text('$ammonia PPM')),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Temperture')),
                                                DataCell(Text('$temp C')),
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Humidity')),
                                                DataCell(Text('$humid%')),
                                              ]),
                                            ],
                                          ),
                                      // DataTable(
                                      //   columns: [
                                      //     DataColumn(label: Text(
                                      //         'Range(PPM) of CO2',
                                      //       style: TextStyle(
                                      //           fontSize: 14,
                                      //           fontWeight: FontWeight.w500
                                      //       ),
                                      //       textAlign: TextAlign.center,
                                      //     )),
                                      //     DataColumn(label: Text(
                                      //         'Status',
                                      //         style: TextStyle(
                                      //         fontSize: 14,
                                      //         fontWeight: FontWeight.w500
                                      //     ),
                                      //       textAlign: TextAlign.center,
                                      //     )),
                                      //   ],
                                      //   rows: [
                                      //     DataRow(cells: [
                                      //       DataCell(Text('0-50')),
                                      //       DataCell(Text('Good')),
                                      //     ]),
                                      //     DataRow(cells: [
                                      //       DataCell(Text('51-100')),
                                      //       DataCell(Text('Moderate')),
                                      //     ]),
                                      //     DataRow(cells: [
                                      //       DataCell(Text('101-200')),
                                      //       DataCell(Text('Unhealthy')),
                                      //     ]),
                                      //     DataRow(cells: [
                                      //       DataCell(Text('201-251')),
                                      //       DataCell(Text('Very Unhealthy')),
                                      //     ]),
                                      //     DataRow(cells: [
                                      //       DataCell(Text('250>')),
                                      //       DataCell(Text('Hazardous')),
                                      //     ]),
                                      //     ],
                                      //   ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Generate detailed report",
                              style: TextStyle(
                                  color: purple
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  purpleLight),
                              elevation: MaterialStateProperty.all(0),
                            ),
                          ),
                        )
                        // Center(
                        //   child: Text(_timeString ?? "Loading", style: TextStyle(fontSize: 24)),
                        // ),
                      ]
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                        child: Text(
                          "Realtime Graphs",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 154,
                            child: DropdownButton(
                              value: selectedIndex == -1 ? null : selectedIndex,
                              hint: Text('Select an option'),
                              items: List.generate(
                                dropdownItems.length,
                                    (index) =>
                                    DropdownMenuItem(
                                      value: index,
                                      child: Text(dropdownItems[index]),
                                    ),
                              ),
                              onChanged: (index) {
                                setState(() {
                                  selectedIndex = index!;
                                  stream = positiveDataStream(selectedIndex);
                                });
                              },
                              alignment: Alignment.center,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  StreamBuilder(
                      stream: stream,
                      builder: (context, snapshot){
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width*0.7,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RealTimeGraph(
                              stream: stream,
                              displayMode: ChartDisplay.points,
                              displayYAxisValues: true,
                            ),
                          ),
                        );
                      }
                  )
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: MediaQuery.of(context).size.width * 0.8,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: RealTimeGraph(
                  //       stream: stream,
                  //     ),
                  //   ),
                  // ),
                ]
            ),
          );
        }
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text(snapshot.error.toString());
        }
        return Text('....');
      }
     );
  }
  // double graph_val(int x){
  //   print("PPM2 : $ppm\n");
  //   print("PPM2: $co\n");
  //   print("PPM2 : $methane\n");
  //   print("PPM2 : $ammonia\n");
  //   print("IND : $selectedIndex\n");
  //
  //   if(x==0) return ppm;
  //   else if(x==1) return co;
  //   else if(x==2) return methane;
  //   else return ammonia;
  // }

  Stream<double> positiveDataStream(int x) {
    if(x==0) {
      return Stream.periodic(const Duration(milliseconds: 1000), (_) {
      return ppm;
    }).asBroadcastStream();
    }
    if(x==1) {
      return Stream.periodic(const Duration(milliseconds: 1000), (_) {
      return co;
    }).asBroadcastStream();
    }
    if(x==2) {
      return Stream.periodic(const Duration(milliseconds: 1000), (_) {
      return methane;
    }).asBroadcastStream();
    }
    if(x==3) {
      return Stream.periodic(const Duration(milliseconds: 1000), (_) {
      return ammonia;
    }).asBroadcastStream();
    }
    return Stream.periodic(const Duration(milliseconds: 1000), (_) {
      return 200.0;
    }).asBroadcastStream();
  }
}






