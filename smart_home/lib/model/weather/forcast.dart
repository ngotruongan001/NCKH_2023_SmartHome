

import 'package:smart_home/model/weather/daily.dart';
import 'package:smart_home/model/weather/hourly.dart';


class Forecast {
  final List<Hourly> hourly;
  final List<Daily> daily;

  Forecast({required this.hourly, required this.daily});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    print(json);
    List<dynamic> hourlyData = json['hourly'];
    List<dynamic> dailyData = json['daily'];

    List<Hourly> hourly = <Hourly>[];
    List<Daily> daily = <Daily>[];

    hourlyData.forEach((item) {
      var hour = Hourly.fromJson(item);
      hourly.add(hour);
    });
    
    dailyData.forEach((item) {
      var day = Daily.fromJson(item);
      daily.add(day);
    });
    
    return Forecast(
      hourly: hourly,
      daily: daily
    );
  }
}