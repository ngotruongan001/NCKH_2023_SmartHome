import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';
import 'package:smart_home/screens/Widget/Rooms/AntiTheft.dart';
import 'package:smart_home/screens/Widget/Rooms/Fire.dart';
import 'package:smart_home/screens/Widget/Rooms/Humidity.dart';
import 'package:smart_home/screens/Widget/Rooms/Light.dart';
import 'package:smart_home/screens/Widget/Rooms/Temperature.dart';
import 'package:smart_home/screens/Widget/Rooms/TopButton.dart';

class Room extends StatefulWidget {
  final  String title;
  final  String floor;

  const Room({ Key? key, required this.floor, required this.title}): super(key: key);


  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {

  bool status = true;
  bool status1 = true;
  bool status2 = true;
  var setI =0;
  var temperature = 0.0;
  var humidity = 0.0;

  late Timer timer;

  @override

  handleClick(i){
    setState((){setI = i;});
  }

  Widget build(BuildContext context) {
    var _page = [
      const Temperature(),
      const Humidity(),
      LightPage(floor: widget.floor, title: widget.title,),
      const FirePage(),
      const AntiTheft()
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children:  [
                        Text(
                          "Tầng ${widget.floor}",
                          style: TextStyle(
                              fontSize: 20,
                              color: context.watch<ThemeProvider>().textColor
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.title}",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                              color: context.watch<ThemeProvider>().textColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TopButton(handleClick: handleClick, setId: setI),
              _page[setI]
            ],
          ),
        ),
      ),
    );
  }
}