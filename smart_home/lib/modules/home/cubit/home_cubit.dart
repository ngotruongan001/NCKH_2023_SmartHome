import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/models/weather.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  var repo = Repository();
  var _weather = Weather();
  ValueNotifier<int> floorCurrentNotifier = ValueNotifier(0);

  void getUserWeatherLocation() async {
    print('initial...');
    try {
      emit(HomeGetDataLoading());
      await Geolocator.requestPermission().then((value) async {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        print('position: ${position.latitude}');
        print('position: ${position.longitude}');
        await repo.getCurrentWeatherLocation(
          handleGetDataSuccess,
          handleGetDataFailed,
          lat: position.latitude,
          lon: position.longitude,
        );
      });
    } catch (e) {
      print("home failed!!!");
      handleGetDataFailed('Get data failed!!!');
    }
  }

  void handleGetDataSuccess(Weather weather) {
    print("Home success!!");
    _weather = weather;
    emit(HomeGetDataSuccess(_weather));
  }

  void handleGetDataFailed(String errorMessage) {
    print("Home failed!!");
    emit(HomeGetDataFailure(errorMessage));
  }

  void onChangeFloorNotifier(int value){
    floorCurrentNotifier.value = value;
  }
}
