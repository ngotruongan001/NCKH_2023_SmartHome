import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/screens/Widget/Floor/CardRoom.dart';

class FirstFloor extends StatefulWidget {
  const FirstFloor({Key? key}) : super(key: key);

  @override
  State<FirstFloor> createState() => _FirstFloorState();
}

class _FirstFloorState extends State<FirstFloor> {
  num temperature = 0;
  num humidity = 0 ;
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
        temperature = value as num;
      });
    });
    getHumiData.onValue.listen((DatabaseEvent event) {
      var value = event.snapshot.value;
      print("humidity}: $value");
      setState(() {
        humidity = value as num ;
      });
    });
  }

  var arrayRoom = [
    {
      'title': "Living Room",
      'image': 'assets/images/livingroom.jpg',
      'floor': 1
    },
    {
      'title': "Kitchen Room",
      'image': 'assets/images/kitchenroom.jpg',
      'floor': 1
    },
    {
      'title': "Bed Room",
      'image': 'assets/images/bedroom.jpg',
      'floor': 1
    },
    {
      'title': "Living Room",
      'image': 'assets/images/livingroom.jpg',
      'floor': 1
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(25),
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          crossAxisCount: 2,
          children: arrayRoom.map((e) =>
              CardRoom(
                  title: e['title'].toString(),
                  temperature: temperature,
                  humidity: humidity,
                  image: e['image'].toString(),
                  floor:  e['floor'].toString()
              )
          ).toList()
      ),
    );
  }
}