import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';
import 'package:smart_home/model/weather/forcast.dart';
import 'package:smart_home/model/weather/location.dart';
import 'package:smart_home/model/weather/weather.dart';
import 'dart:convert';
import 'extensions.dart';
import 'package:intl/intl.dart';

class CurrentWeatherPage extends StatefulWidget {
  final List<Location> locations;
  final BuildContext context;
  const CurrentWeatherPage(this.locations, this.context);

  @override
  _CurrentWeatherPageState createState() =>
      _CurrentWeatherPageState(locations, context);
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  late var lat = 0.0;
  late var lon = 0.0;

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
    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
  }

  final List<Location> locations;
  Location location;
  @override
  final BuildContext context;
  _CurrentWeatherPageState(this.locations, this.context)
      : location = locations[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.watch<ThemeProvider>().backgroundWeather,
        body: ListView(children: <Widget>[
          currentWeatherViews(locations, location, this.context),
          forcastViewsHourly(location),
          forcastViewsDaily(location),
        ]));
  }

  Widget currentWeatherViews(
      List<Location> locations, Location location, BuildContext context) {
    Weather? _weather;

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _weather = snapshot.data as Weather?;
          if (_weather == null) {
            return const Text("Error getting weather");
          } else {
            return Column(children: [
              // CityDropDown(locations),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 30, 20, 15),
                decoration: BoxDecoration(
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Weather",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color:
                              context.watch<ThemeProvider>().textColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              weatherBox(_weather!),
              weatherDetailsBox(_weather!),
            ]);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      future: getCurrentWeather(lat, lon),
    );
  }

  Widget forcastViewsHourly(Location location) {
    Forecast? _forcast;

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _forcast = snapshot.data as Forecast?;
          if (_forcast == null) {
            return const Text("Error getting weather");
          } else {
            return hourlyBoxes(_forcast!);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      future: getForecast(lat, lon),
    );
  }

  Widget forcastViewsDaily(Location location) {
    Forecast? _forcast;

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _forcast = snapshot.data as Forecast?;
          if (_forcast == null) {
            return const Text("Error getting weather");
          } else {
            return dailyBoxes(_forcast!);
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      future: getForecast(lat, lon),
    );
  }

  Widget weatherDetailsBox(Weather _weather) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
      margin: const EdgeInsets.only(left: 15, top: 5, bottom: 15, right: 15),
      decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().cardDashBoard,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
      child: Row(
        children: [
          Expanded(
              child: Column(
                children: [
                   Text(
                    "Wind",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: context.watch<ThemeProvider>().textColor),
                  ),
                  Text(
                    "${_weather.wind} km/h",
                    textAlign: TextAlign.left,
                    style:  TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: context.watch<ThemeProvider>().textColor),
                  )
                ],
              )),
          Expanded(
              child: Column(
                children: [
                   Text(
                    "Humidity",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: context.watch<ThemeProvider>().textColor),
                  ),
                  Text(
                    "${_weather.humidity.toInt()}%",
                    textAlign: TextAlign.left,
                    style:  TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: context.watch<ThemeProvider>().textColor),
                  )
                ],
              )),
          Expanded(
              child: Column(
                children: [
                  Container(
                      child:  Text(
                        "Pressure",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: context.watch<ThemeProvider>().textColor),
                      )),
                  Container(
                      child: Text(
                        "${_weather.pressure} hPa",
                        textAlign: TextAlign.left,
                        style:  TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: context.watch<ThemeProvider>().textColor),
                      ))
                ],
              ))
        ],
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Stack(children: [
      Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.all(15.0),
        height: 210.0,
        decoration: const BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
      ClipPath(
          clipper: Clipper(),
          child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(15.0),
              height: 210.0,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent[400],
                  borderRadius: const BorderRadius.all(Radius.circular(20))))),
      Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15.0),
          height: 210.0,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.all(5.0),
                            child: Text(
                              _weather.city,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 27,
                                  color: Colors.white,),
                            )),
                        getWeatherIcon(_weather.icon),
                        Container(
                            margin: const EdgeInsets.all(5.0),
                            child: Text(
                              _weather.description.capitalizeFirstOfEach,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.white),
                            )),
                        Container(
                            margin: const EdgeInsets.all(5.0),
                            child: Text(
                              "H:${_weather.high.toInt()}° L:${_weather.low.toInt()}°",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Colors.white),
                            )),
                      ])),
              Column(children: <Widget>[
                Container(
                    child: Text(
                      "${_weather.temp.toInt()}°",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          color: Colors.white),
                    )),
                Container(
                    margin: const EdgeInsets.all(0),
                    child: Text(
                      "Feels like ${_weather.feelsLike.toInt()}°",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.white),
                    )),
              ])
            ],
          ))
    ]);
  }

  Image getWeatherIcon(String _icon) {
    String path = 'assets/images/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 70,
      height: 70,
    );
  }

  Image getWeatherIconSmall(String _icon) {
    String path = 'assets/images/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 40,
      height: 40,
    );
  }

  Widget hourlyBoxes(Forecast _forecast) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 0.0),
        height: 150.0,
        child: ListView.builder(
            padding:
            const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: _forecast.hourly.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 15, bottom: 15, right: 10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: context.watch<ThemeProvider>().cardDashBoard,
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 1), // changes position of shadow
                        )
                      ]),
                  child: Column(children: [
                    Text(
                      "${_forecast.hourly[index].temp}°",
                      style:  TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: context.watch<ThemeProvider>().textColor),
                    ),
                    getWeatherIcon(_forecast.hourly[index].icon),
                    Text(
                      getTimeFromTimestamp(_forecast.hourly[index].dt),
                      style:  TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey),
                    ),
                  ]));
            }));
  }

  String getTimeFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('h:mm a');
    return formatter.format(date);
  }

  String getDateFromTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = DateFormat('E');
    return formatter.format(date);
  }

  Widget dailyBoxes(Forecast _forcast) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding:
            const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
            itemCount: _forcast.daily.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 10),
                  margin: const EdgeInsets.all(5),
                  child: Row(children: [
                    Expanded(
                        child: Text(
                          getDateFromTimestamp(_forcast.daily[index].dt),
                          style:  TextStyle(fontSize: 14, color: context.watch<ThemeProvider>().textColor),
                        )),
                    Expanded(
                        child: getWeatherIconSmall(_forcast.daily[index].icon)),
                    Expanded(
                        child: Text(
                          "${_forcast.daily[index].high.toInt()}/${_forcast.daily[index].low.toInt()}",
                          textAlign: TextAlign.right,
                          style:  TextStyle(fontSize: 14, color: context.watch<ThemeProvider>().textColor),
                        )),
                  ]));
            }));
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 20);

    path.quadraticBezierTo((size.width / 6) * 1, (size.height / 2) + 15,
        (size.width / 3) * 1, size.height - 30);
    path.quadraticBezierTo((size.width / 2) * 1, (size.height + 0),
        (size.width / 3) * 2, (size.height / 4) * 3);
    path.quadraticBezierTo((size.width / 6) * 5, (size.height / 2) - 20,
        size.width, size.height - 60);

    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}

Future getCurrentWeather(num lat,num lon) async {
  Weather? weather;

  String apiKey = "026de487fd6c8b4cc0bb10493dd97183";
  var url =
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  }

  return weather;
}

Future getForecast(num lat,num lon) async {
  Forecast? forecast;
  String apiKey = "026de487fd6c8b4cc0bb10493dd97183";
  var url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    forecast = Forecast.fromJson(jsonDecode(response.body));
  }
  return forecast;
}