import 'package:flutter/material.dart';
import 'package:smart_home/model/MessageModel.dart';
import 'package:dio/dio.dart';

class DataProvider extends ChangeNotifier {
  List<MessageModel> list = [];

  void fetchApiMessage() async {
    try {
      List<MessageModel> _newList = [];
      var response = await Dio().get('https://api-notification-smarthome.herokuapp.com/api/v1/message');
      print("response");
      // Message newsResponse = Message.fromJson(response.data);
      var m = response.data;
      for(var i in m){
        _newList.add(new MessageModel.fromJson(i));
      }
      for(var i in _newList){
        print("title: "+i.title+" - "+i.description+" - "+i.status+" - "+i.createdAt);
      }
      list = _newList;
      notifyListeners();
    } catch (e) {
      print("err");
      print(e);
    }
  }
}