import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';

class NotificationTiles extends StatefulWidget {
  final String title, subtitle;
  final Function onTap;
  final bool enable;
  final String status;
  const NotificationTiles({
    Key? key, required this.title, required this.subtitle, required this.onTap, required this.enable, required this.status
  }) : super(key: key);

  @override
  State<NotificationTiles> createState() => _NotificationTilesState();
}

class _NotificationTilesState extends State<NotificationTiles> {

  getPicture(String status) {
    switch (status) {
      case '1':
        return 'assets/images/anti-theft.png';
      case '2':
        return 'assets/images/fire.png';
      case '3':
        return 'assets/images/fire.png';
      case '4':
        return 'assets/images/rain-warning.png';
      case '5':
        return 'assets/images/temp-warning.png';
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 50.0,
          width: 50.0,
          padding: EdgeInsets.all(200),
          decoration:  BoxDecoration(
              color:  context.watch<ThemeProvider>().iconNotiCard,
              image: DecorationImage(
                image: AssetImage(getPicture(widget.status)),
                fit: BoxFit.cover,))),
      title: Text(widget.title, style: const TextStyle(color: Colors.deepOrange)),
      subtitle: Text(widget.subtitle,
          style:  TextStyle( color: context.watch<ThemeProvider>().textColor)),
      onTap: (){
      },
      enabled: widget.enable,
    );
  }
}