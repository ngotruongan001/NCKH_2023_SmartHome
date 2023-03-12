import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';
import 'package:smart_home/model/RoomCart.dart';
import 'package:smart_home/model/weather/weather.dart';
import 'package:smart_home/screens/Widget/Floor/ChooseFloor.dart';
import 'package:smart_home/screens/Widget/Floor/FirstFloor.dart';
import 'package:smart_home/screens/Widget/Floor/SecondFloor.dart';
import 'package:smart_home/screens/Widget/Floor/ThirdFloor.dart';
import 'package:smart_home/screens/Widget/Weather/extensions.dart';
import 'package:smart_home/viewmodel/RoomCart_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late var lat = 0.0;
  late var lon = 0.0;
  late var temp = 0.0;
  late var humi =0.0;
  var description = "";
  var icon = "";

  @override
  void initState() {

    _getUserLocation();
    super.initState();
  }
  void _getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('position: ${position.latitude}');
    print('position: ${position.longitude}');
    getCurrentWeather(position.latitude,position.longitude);
    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
  }

  Future getCurrentWeather(num lat,num lon) async {
    Weather? weather;
    String apiKey = "026de487fd6c8b4cc0bb10493dd97183";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
      getWeatherIcon(icon);
      setState(() {
        temp = weather!.temp;
        humi = weather.humidity;
        description = weather.description.capitalizeFirstOfEach;
        icon = weather.icon;
      });
    }
    print(weather);
    return weather;
  }

  Image getWeatherIcon(String _icon) {

    String path = 'assets/images/';
    String imageExtension = ".png";
    return Image.asset(
      _icon.isEmpty ?  path + "loading" + imageExtension :path + _icon + imageExtension ,
      width: 70,
      height: 70,
    );
  }
  @override

  List<RoomCart> listRoom = rooms;
  var setId = 0;
  handleClick(i){
    setState((){setId = i;});
  }

  @override
  Widget build(BuildContext context) {
    var _page = [
      const FirstFloor(),
      const SecondFloor(),
      const ThirdFloor()
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
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
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
              Container(
                decoration: BoxDecoration(
                  color: context.watch<ThemeProvider>().weatherCard,
                  borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 1), // changes position of shadow
                      )
                    ]
                ),
                margin: const EdgeInsets.only(left: 16, right: 16, top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 8),
                            child:  Text("Weather",
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: context.watch<ThemeProvider>().textColor

                                )),
                          ),
                          Container(
                            margin:  EdgeInsets.only(
                                left: 8, right: 8, top: 0, bottom: 0),
                            child:  Text("Temperature: ${temp.toInt()}°C",
                                style: TextStyle(
                                  fontSize: 16,
                                    color: context.watch<ThemeProvider>().textColor
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 8, right: 8, top: 8, bottom: 8),
                            child:  Text("Humidity: ${humi.toInt()}%",
                                style: TextStyle(
                                  fontSize: 16,
                                    color: context.watch<ThemeProvider>().textColor
                                )),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        getWeatherIcon(icon),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 8),
                          child:  Text(description,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: context.watch<ThemeProvider>().textColor
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ChooseFloor(handleClick: handleClick, setId: setId),
              _page[setId]
            ],
          ),
        ),
      ),
    );

    // This trailing comma makes auto-formatting nicer for build methods.
  }

}