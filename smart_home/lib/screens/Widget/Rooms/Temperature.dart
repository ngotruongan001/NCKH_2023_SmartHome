import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';

class Temperature extends StatefulWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  bool status = true;
  bool status1 = true;
  var setI =0;
  var temperature = 0.0;
  var humidity = 0.0;

  late Timer timer;

  @override

  void initState() {
    super.initState();
    //callApi();
    // timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => );
    callApi();
  }
  void callApi() {
    getNewsData();
  }
  var url1 = "https://api.thingspeak.com/channels/1679055/feeds.json?api_key=VR0TQ44DF1FJZ9TX&results=2";
  getNewsData() async  {
    var response = await http.get(Uri.parse(url1));

    var _newTemperature= 0.0;
    var _newHumidity= 0.0;

    if(response.statusCode == 200){
      List m = jsonDecode(response.body)['feeds'];
      _newTemperature =  double.parse(m[m.length - 1]["field1"]);
      _newHumidity = double.parse(m[m.length - 1]["field2"]);
      print(m);
    }else{
      _newTemperature = 0.0;
      _newHumidity = 0.0;
    }


    setState((){
      temperature= _newTemperature;
      humidity = _newHumidity;
    });
  }


  handleClick(i){
    setState((){setI = i;});
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CircularPercentIndicator(
                      animation: true,
                      animationDuration: 2500,
                      radius: 220,
                      lineWidth: 15,
                      percent: temperature/100,
                      progressColor: context.watch<ThemeProvider>().progressColor,
                      backgroundColor: context.watch<ThemeProvider>().backgroundProgressColor,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Text("Temp", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: context.watch<ThemeProvider>().textColor
                          ),),
                          const SizedBox(height: 10,),
                          Text( '${temperature}°C', style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.deepOrange
                          ),)
                        ],
                      ),
                    ),

                  ],
                ),
              ),),
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children:  [
                                Text(
                                  "Sensor",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                      color: context.watch<ThemeProvider>().textColor),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Switch(
                                  activeColor: Colors.deepOrange,
                                  value: status,
                                  onChanged: (bool val) {
                                    setState(() {
                                      status = val;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children:  [
                                Text(
                                  "70%",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                  color: context.watch<ThemeProvider>().textColor),
                                )
                              ],
                            ),
                            Column(
                              children: const [
                                Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.deepOrange,
                                )
                              ],
                            ),
                            Column(
                              children: const [
                                Icon(
                                  Icons.add_circle,
                                  color: Colors.deepOrange,
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                             Text(
                              "Temperature",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: context.watch<ThemeProvider>().textColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${temperature}°C',
                              style:  TextStyle(
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
                      children: [
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Column(
                              children:  [
                                Text(
                                  "Specifications:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                      color: context.watch<ThemeProvider>().textColor),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children:  [
                                Text(
                                  "Power: 3 -> 5 VDC",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
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
                              height: 5,
                            ),
                            Text(
                              "Temp range: 0-50°C( ±2°C)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: context.watch<ThemeProvider>().textColor,fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Samplefrequency: 1Hz(1s/time)',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
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
        )
    );
  }
}
