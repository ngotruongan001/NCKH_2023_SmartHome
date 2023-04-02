import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/common/widgets/Widget/Floor/ChooseFloor.dart';
import 'package:smart_home/common/widgets/Widget/Floor/FirstFloor.dart';
import 'package:smart_home/common/widgets/Widget/Floor/SecondFloor.dart';
import 'package:smart_home/common/widgets/Widget/Floor/ThirdFloor.dart';
import 'package:smart_home/common/widgets/Widget/Weather/extensions.dart';
import 'package:smart_home/models/RoomCart.dart';
import 'package:smart_home/models/weather.dart';
import 'package:smart_home/modules/home/cubit/home_cubit.dart';
import 'package:smart_home/themes/theme_provider.dart';
import 'package:smart_home/viewmodel/RoomCart_viewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var bloc = HomeCubit();
  @override
  void initState() {
    super.initState();
    bloc.getUserWeatherLocation();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  Image getWeatherIcon(String _icon) {
    String path = 'assets/images/';
    String imageExtension = ".png";
    return Image.asset(
      _icon.isEmpty
          ? path + "loading" + imageExtension
          : path + _icon + imageExtension,
      width: 70,
      height: 70,
    );
  }

  @override
  List<RoomCart> listRoom = rooms;
  var setId = 0;

  @override
  Widget build(BuildContext context) {
    var _page = [const FirstFloor(), const SecondFloor(), const ThirdFloor()];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 8),
                height: 80,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome",
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      context.watch<ThemeProvider>().textColor),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Trường An",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      context.watch<ThemeProvider>().textColor),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              "assets/images/ngotruongan.jpg",
                              width: 60.0,
                              height: 60.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is HomeGetDataLoading) {
                    return Text("Loading!!!");
                  }
                  if (state is HomeGetDataFailure) {
                    var errorMessage = state.errorMessage;
                    return Text(errorMessage);
                  }
                  if (state is HomeGetDataSuccess) {
                    var weather = state.weather;
                    return Container(
                      decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().weatherCard,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            )
                          ]),
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 8, right: 8, top: 8, bottom: 8),
                                  child: Text("Weather",
                                      style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                          color: context
                                              .watch<ThemeProvider>()
                                              .textColor)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 8, right: 8, top: 0, bottom: 0),
                                  child: Text("Temperature: ${weather.temp}°C",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: context
                                              .watch<ThemeProvider>()
                                              .textColor)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 8, right: 8, top: 8, bottom: 8),
                                  child: Text("Humidity: ${weather.humidity}%",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: context
                                              .watch<ThemeProvider>()
                                              .textColor)),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              getWeatherIcon(weather.icon ?? ''),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 8, right: 8, top: 8, bottom: 8),
                                child: Text(weather.description ?? '',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: context
                                            .watch<ThemeProvider>()
                                            .textColor)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                  return Text("Initial...");
                },
              ),
              ValueListenableBuilder<int>(
                  valueListenable: bloc.floorCurrentNotifier,
                  builder: (context, index, _) {
                    return Column(
                      children: [
                        ChooseFloor(
                            handleClick: bloc.onChangeFloorNotifier,
                            setId: index),
                        _page[index],
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
