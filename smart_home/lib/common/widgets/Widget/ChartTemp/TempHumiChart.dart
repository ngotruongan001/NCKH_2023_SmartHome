import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TempHumiChart extends StatefulWidget {
  TempHumiChart({Key? key}) : super(key: key);

  @override
  _TempHumiChartState createState() => _TempHumiChartState();
}

class _TempHumiChartState extends State<TempHumiChart> {
  late List<LiveData> chartData;
  late List<LiveData2> chartData2;
  late TooltipBehavior _tooltipBehavior;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesController2;

  num temperature = 0;
  num humidity = 0 ;

  @override

  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    chartData = getChartData();
    chartData2 = getChartData2();
    Timer.periodic(const Duration(seconds: 5), updateDataSource);
    Timer.periodic(const Duration(seconds: 5), updateDataSource2);

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
        humidity = value as num;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
              width: 400,
              height: 500,
              child: SfCartesianChart(
                title: ChartTitle(text: 'Temperature & Humidity'),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <SplineSeries>[
                  SplineSeries<LiveData, double>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController = controller;
                      },
                      name: 'Temperature',
                      dataSource: chartData,
                      xValueMapper: (LiveData sales, _) => sales.time,
                      yValueMapper: (LiveData sales, _) => sales.speed,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      color: Colors.red,
                      width: 4,
                      opacity: 1,
                      dashArray: <double>[1, 1],
                      splineType: SplineType.cardinal,
                      cardinalSplineTension: 0.0),
                  SplineSeries<LiveData2, double>(
                      onRendererCreated: (ChartSeriesController controller2) {
                        _chartSeriesController2 = controller2;
                      },
                      name: 'Humidity',
                      dataSource: chartData2,
                      xValueMapper: (LiveData2 sales, _) => sales.time,
                      yValueMapper: (LiveData2 sales, _) => sales.speed,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      color: Colors.blueAccent,
                      width: 4,
                      opacity: 1,
                      dashArray: <double>[1, 1],
                      splineType: SplineType.cardinal,
                      cardinalSplineTension: 0.0),

                ],
                primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),

              ),
            );
  }


  double time = 6;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time+=5, temperature));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  double time2 = 6;
  void updateDataSource2(Timer timer) {
    chartData2.add(LiveData2(time2+=5, humidity));
    chartData2.removeAt(0);
    _chartSeriesController2.updateDataSource(
        addedDataIndex: chartData2.length - 1, removedDataIndex: 0);
  }

  List<LiveData2> getChartData2() {
    return <LiveData2>[
      LiveData2(0, 40),
      LiveData2(1, 45),
      LiveData2(2, 50),
      LiveData2(3, 55),
      LiveData2(4, 60),
      LiveData2(5, 75)

    ];
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 20),
      LiveData(1, 22),
      LiveData(2, 15),
      LiveData(3, 17),
      LiveData(4, 18),
      LiveData(5, 22)
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final double time;
  final num speed;
}
class LiveData2 {
  LiveData2(this.time, this.speed);
  final double time;
  final num speed;
}

