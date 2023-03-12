import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomColors extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  bool mainBgHome = false;

  static Color primaryTextColor = Colors.deepOrange;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor =  Color(0xFF242634);
  static Color menuBackgroundColor = const Color(0xFF242634);

  static Color clockBG = const Color(0xFF444974);
  static Color clockOutline = const Color(0xFFEAECFF);
  static Color? secHandColor = Colors.orange[300];
  static Color minHandStatColor = const Color(0xFF748EF6);
  static Color minHandEndColor = const Color(0xFF77DDFF);
  static Color hourHandStatColor = const Color(0xFFC279FB);
  static Color hourHandEndColor = const Color(0xFFEA74AB);

  updateBg(bool _check) {
    if(_check){
      pageBackgroundColor = const Color(0xFF242634);
      primaryTextColor = Color(0xFF242634);
      dividerColor = Colors.white54;

      clockOutline = const Color(0xFFEAECFF);
      secHandColor = Colors.orange[300];

    }else{
      pageBackgroundColor = Colors.white;
      primaryTextColor = Colors.deepOrange;
      dividerColor = Colors.black54;

      clockBG = const Color(0xFF444974);
      clockOutline = const Color(0xFF242634);
    }

    mainBgHome = _check;
    notifyListeners();
  }
}

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [const Color(0xFF6448FE), const Color(0xFF5FC6FF)];
  static List<Color> sunset = [const Color(0xFFFE6197), const Color(0xFFFFB463)];
  static List<Color> sea = [const Color(0xFF61A3FE), const Color(0xFF63FFD5)];
  static List<Color> mango = [const Color(0xFFFFA738), const Color(0xFFFFE130)];
  static List<Color> fire = [const Color(0xFFFF5DCD), const Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}