import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/screens/Widget/Floor/CardRoom.dart';

class ThirdFloor extends StatefulWidget {
  const ThirdFloor({Key? key}) : super(key: key);

  @override
  State<ThirdFloor> createState() => _ThirdFloorState();
}

class _ThirdFloorState extends State<ThirdFloor> {
  var temperature;
  var humidity;
  @override
  void initState() {
    super.initState();
    final database = FirebaseDatabase.instance.reference();
    final read = database.child("/ESP32_Device");
    final getTempData = read.child("/Temperature/Data");
    final getHumiData = read.child("/Humidity/Data");
    getTempData.onValue.listen((DatabaseEvent event) {
      var value = event.snapshot.value;
      print("temperature}: $value");
      setState(() {
        temperature = value;
      });
    });
    getHumiData.onValue.listen((DatabaseEvent event) {
      var value = event.snapshot.value;
      print("humidity}: $value");
      setState(() {
        humidity = value;
      });
    });
  }

  var arrayRoom = [
    {'title': "Terrace", 'image': 'assets/images/terrace.jpg', 'floor': 3},
    {'title': "Bed Room", 'image': 'assets/images/bedroomt2.jpg', 'floor': 3},
    {'title': "Bath Room", 'image': 'assets/images/bathroom2.jpg', 'floor': 3},

  ];

  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(25),
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          crossAxisCount: 2,
          children: arrayRoom
              .map((e) => CardRoom(
              title: e['title'].toString(),
              temperature: temperature,
              humidity: humidity,
              image: e['image'].toString(),
              floor: e['floor'].toString()))
              .toList()
        // <Widget>[
        //   CardRoom(title: "Terrace",temperature: temperature,humidity: humidity,image: 'assets/images/terrace.jpg', floor: '3'),
        //   CardRoom(title: "Bed Room",temperature: temperature,humidity: humidity,image: 'assets/images/bedroomt2.jpg', floor: '3'),
        //   CardRoom(title: "Bath Room",temperature: temperature,humidity: humidity,image: 'assets/images/bathroom2.jpg', floor: '3'),
        //
        // ],
      ),
    );
  }
}