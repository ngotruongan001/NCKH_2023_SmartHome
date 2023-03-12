import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_home/model/weather/location.dart';
import 'package:smart_home/model/weather/weather.dart';
import 'package:smart_home/screens/Widget/Weather/currentWeather.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({Key? key}) : super(key: key);

  @override
  State<WeatherHome> createState() => _WeatherHomeState();

}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  void initState() {
    print("An");
    _getUserLocation();
    super.initState();
  }
  void _getUserLocation() async {
  LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("Tính ngu");
    print('position: ${position.latitude}');
    print('position: ${position.longitude}');
  Weather n = getForecast("${position.latitude}","${position.longitude}") as Weather;

  }
  List<Location> locations = [
    Location(
        city: "calgary",
        country: "canada",
        lat: "51.0407154",
        lon: "-114.1513999"),
    Location(
        city: "edmonton",
        country: "canada",
        lat: "53.5365386",
        lon: "-114.1513999")
  ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: CurrentWeatherPage(locations, context),
      debugShowCheckedModeBanner: false,
    );
  }

  Future getForecast(String lat, String lon) async {
    Weather? forecast;
    String apiKey = "026de487fd6c8b4cc0bb10493dd97183";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      forecast = Weather.fromJson(jsonDecode(response.body));
    }

    return forecast;
  }

}
