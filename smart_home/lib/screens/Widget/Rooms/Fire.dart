import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';

class FirePage extends StatefulWidget {
  const FirePage({Key? key}) : super(key: key);

  @override
  State<FirePage> createState() => _FirePageState();
}

class _FirePageState extends State<FirePage> {
  var ppm = 0;

  @override
  void initState() {
    super.initState();
    final database = FirebaseDatabase.instance.reference();
    final read = database.child("/ESP32_Device");
    final getTimesAntiTheft= read.child("/AntiFire/PPM");
    getTimesAntiTheft.onValue.listen((DatabaseEvent event) {
      var value = event.snapshot.value;
      print("PPM}: $value");
      setState(() {
        ppm = value as int;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
          height: 800,
          // alignment: Alignment.topCenter, //inner widget alignment to center
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 250,
                      width: 250,
                      child: Lottie.asset('assets/json/tick.json', repeat: false,)),
                   Text(
                    ppm >= 100? "Dangerous State": "Safe State",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.deepOrange),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(
                    height: 400 ,
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: context.watch<ThemeProvider>().cardDashBoard,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children:  [
                                      Text(
                                        "Sensor 1",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                            color: context.watch<ThemeProvider>().textColor),
                                      )
                                    ],
                                  ),

                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Active status",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: context.watch<ThemeProvider>().textColor, fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   Text(
                                    "flammable gas concentration",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        color: context.watch<ThemeProvider>().textColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   Text(
                                    '$ppm PPM',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: context.watch<ThemeProvider>().textColor),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: context.watch<ThemeProvider>().cardDashBoard,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children:  [
                                      Text(
                                        "Sensor 2",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 19,
                                            color: context.watch<ThemeProvider>().textColor),
                                      )
                                    ],
                                  ),

                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Active status",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: context.watch<ThemeProvider>().textColor, fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "flammable gas concentration",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        color: context.watch<ThemeProvider>().textColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      '$ppm PPM',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: context.watch<ThemeProvider>().textColor),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),

            ],
          )),
    );
  }
}
