import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';
import 'package:smart_home/screens/Widget/ChartTemp/TempHumiChart.dart';
import 'package:smart_home/screens/Widget/DashBoard/DarshBoard_FirstFloor.dart';
import 'package:smart_home/screens/Widget/DashBoard/DarshBoard_SecondFloor.dart';
import 'package:smart_home/screens/Widget/DashBoard/DarshBoard_ThirdFloor.dart';
import 'package:smart_home/screens/Widget/Floor/ChooseFloor.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool status = false;
  late bool ledstatus;
  late int leddata = 0;
  var dateTime = DateTime.now();
  late Timer timer;

  var setId = 0;
  handleClick(i){
    setState((){setId = i;});
  }


  @override
  void initState() {
    ledstatus = false; //initially leadstatus is off so its FALSE
    this.timer = Timer.periodic(const Duration(seconds: 1), (timer) {

      setState(() {
        dateTime = DateTime.now();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (!timezoneString.startsWith('-')) offsetSign = '+';
    var _page = [
      const DarshBoardFirstFloor(),
      const DarshBoardSecondFloor(),
      const DarshBoardThirdFloor(),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                height: 80,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text("Welcome",
                            style: TextStyle(
                                fontSize: 20,
                                color: context.watch<ThemeProvider>().textColor

                            ),),
                          SizedBox(height: 10,),
                          Text(
                            "Trường An",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: context.watch<ThemeProvider>().textColor
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // if(user.photoURL! != null)
                          // CircleAvatar(
                          //   radius: 35,
                          //   backgroundImage: NetworkImage(user.photoURL!,scale: 1),
                          // ) else Container(
                          //   child: Image.network(
                          //       _userData!['picture']['data']['url']),
                          // ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              "assets/images/ngotruongan.jpg",
                              width: 60.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.watch<ThemeProvider>().weatherCard,
                            borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1), // changes position of shadow
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    "assets/images/clock.png",
                                    width: 35.0,
                                    height: 35.0,
                                    fit: BoxFit.cover,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                 Text(
                                  "Time now ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                      color: context.watch<ThemeProvider>().textColor
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                 Text(
                                  "$formatTime | $formattedDate ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                      color: context.watch<ThemeProvider>().textColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.watch<ThemeProvider>().weatherCard,
                            borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1), // changes position of shadow
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    "assets/images/flash.png",
                                    width: 35.0,
                                    height: 35.0,
                                    fit: BoxFit.cover,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                 Text(
                                  "Electric used",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w100,
                                      color: context.watch<ThemeProvider>().textColor
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                 Text(
                                  "5 Kw/h | 0.8 \$ ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                      color: context.watch<ThemeProvider>().textColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: context.watch<ThemeProvider>().cardDashBoard,
                    borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 1), // changes position of shadow
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      ChooseFloor(handleClick: handleClick, setId: setId),
                      _page[setId],

                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                      color: context.watch<ThemeProvider>().cardDashBoard,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 1), // changes position of shadow
                        )
                      ]
                  ),
                  child: Column(
                    children: [

                      const SizedBox(
                        height: 20,
                      ),
                      TempHumiChart(),
                    ],
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
