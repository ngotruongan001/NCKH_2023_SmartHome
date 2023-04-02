part of 'home_cubit.dart';


@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeGetDataLoading extends HomeState {}

class HomeGetDataFailure extends HomeState {
  final String errorMessage;

  HomeGetDataFailure(this.errorMessage);
}

class HomeGetDataSuccess extends HomeState {
  Weather weather;
  HomeGetDataSuccess(this.weather);
}

