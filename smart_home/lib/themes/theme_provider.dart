import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  bool mainBgHome = false;
  Color primaryTextColor = Colors.deepOrange;
  Color pageBackgroundColor = Colors.white;
  Color BackgroundColor = Color.fromRGBO(245, 245, 245, 1);
  Color cardProfileCorlor = Colors.white;
  Color textColor = Colors.black;
  Color bubbleBottomBarIcon = Colors.deepOrange;
  Color bubblebackgroundColor = Colors.red;
  Color weatherCard = Colors.white70;
  Color switchColor = Colors.deepOrange;
  Color backgroundClick = Colors.deepOrange;
  Color backgroundNonClick = Colors.green;
  Color textClickColor = Colors.black;
  Color textNonClickColor = Colors.black;
  Color cardDashBoard = Colors.white;
  Color iconNotiCard = Colors.deepOrange;
  Color backgroundTopBar = Colors.white;
  Color progressColor = Colors.deepOrange;
  Color backgroundProgressColor = Colors.deepOrange.shade200;
  Color? backgroundWeather = Colors.grey[100];
  Color backgroundFeedback = Colors.white;

  Color getColor() {
    return pageBackgroundColor;
  }

  updateBg(bool _check) {
    if (_check) {
      pageBackgroundColor =  Color.fromRGBO(49, 62, 107, 1);
      primaryTextColor = Colors.white;
      BackgroundColor = Color.fromRGBO(4, 18, 61, 1);
      cardProfileCorlor = Color.fromRGBO(49, 62, 107, 1);
      textColor = Colors.white;
      bubbleBottomBarIcon =  Color.fromRGBO(74, 208, 238, 1);
      weatherCard = Color.fromRGBO(74, 208, 238, 1);
      bubblebackgroundColor =  Color.fromRGBO(74, 208, 238, 1);
      switchColor = Color.fromRGBO(74, 208, 238, 1);
      backgroundClick = Color.fromRGBO(74, 208, 238, 1);
      backgroundNonClick = Color.fromRGBO(49, 62, 107, 1);
      textClickColor = Colors.white;
      textNonClickColor = Colors.white;
      cardDashBoard = Color.fromRGBO(130, 204, 227, 0.2);
      iconNotiCard = Color.fromRGBO(74, 208, 238, 1);
      backgroundTopBar = Color.fromRGBO(130, 204, 227, 0.2);
      progressColor = Color.fromRGBO(74, 208, 238, 1);
      backgroundProgressColor = Color.fromRGBO(130, 204, 227, 0.2);
      backgroundWeather = Color.fromRGBO(49, 62, 107, 1);
      backgroundFeedback = Color.fromRGBO(49, 62, 107, 1);


    } else {
      backgroundFeedback = Colors.white;
      backgroundWeather = Colors.grey[100];
      backgroundProgressColor = Colors.deepOrange.shade200;
      progressColor = Colors.deepOrange;
      backgroundTopBar = Colors.white;
      iconNotiCard = Colors.deepOrange;
      cardDashBoard = Colors.white;
      textNonClickColor = Colors.white;
      textClickColor = Colors.white;
      backgroundNonClick = Colors.green;
      backgroundClick =  Colors.deepOrange;
      switchColor = Colors.grey;
      cardProfileCorlor = Colors.white;
      pageBackgroundColor = Colors.white;
      primaryTextColor = Colors.deepOrange;
      BackgroundColor = Color.fromRGBO(245, 245, 245, 1);
      textColor = Colors.black;
      bubbleBottomBarIcon = Colors.deepOrange;
      bubblebackgroundColor = Colors.red;
      weatherCard = Colors.white70;
    }
    print(_check);
    mainBgHome = _check;
    notifyListeners();
  }

  initialize() {
    mainBgHome = false;
    updateBg(false);
  }
}