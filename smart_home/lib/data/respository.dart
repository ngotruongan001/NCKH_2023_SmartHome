import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:smart_home/authentication/auth_services.dart';
import 'package:smart_home/models/weather.dart';
import 'package:smart_home/modules/login/login/models/request_user.dart';

class Repository {
  final dio = Dio();
  final _auth = FirebaseAuth.instance;

  Future<void> login(Function onSuccess, Function(String) onFailure,
      {required RequestUser requestUser}) async {
    try {
      print('user: ${requestUser.email}');
      await _auth
          .signInWithEmailAndPassword(
        email: requestUser.email ?? '',
        password: requestUser.password ?? '',
      )
          .then((uid) {
        print("uid: $uid");
        onSuccess();
      });
    } on FirebaseAuthException catch (error) {
      var errorMessage = '';
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Email không đúng định dạng.";

          break;
        case "wrong-password":
          errorMessage = "Mật khẩu của bạn không đúng.";
          break;
        case "user-not-found":
          errorMessage = "Tài khoản này không tồn tại.";
          break;
        case "user-disabled":
          errorMessage = "Tài khoản của bạn đã bị khoá.";
          break;
        case "too-many-requests":
          errorMessage = "Quá nhiều yêu cầu";
          break;
        case "operation-not-allowed":
          errorMessage = "Đăng nhập bằng mật khẩu và email không được bật";
          break;
        default:
          errorMessage = "Đã xảy ra lỗi không xác định.";
      }
      onFailure(errorMessage);
      print("errorMessage $errorMessage");
    }
  }

  Future<void> loginFacebook(
      Function onSuccess, Function(String) onFailure) async {
    try {
      final result =
          await FacebookAuth.i.login(permissions: ["public_profile", "email"]);
      if (result.status == LoginStatus.success) {
        final requestData =
            await FacebookAuth.i.getUserData(fields: "email, name");
        print("requestData: $requestData");
        onSuccess();
      } else {
        onFailure("Login failed!!!");
      }
    } catch (e) {
      onFailure("Login failed!!!");
    }
  }

  Future<void> loginGmail(
      Function onSuccess, Function(String) onFailure) async {
    try {
      await FirebaseServices()
          .signInWithGoogle()
          .then((value) => print("value: $value"));
      onSuccess();
    } catch (e) {
      onFailure("Login failed!!!");
    }
  }

  Future<void> getCurrentWeatherLocation(
    Function(Weather) onSuccess,
    Function(String) onFailure, {
    required double lat,
    required double lon,
  }) async {
    try {
      String apiKey = "026de487fd6c8b4cc0bb10493dd97183";
      var url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";
      print("url: $url");
      await dio.get(url).then((value) {
        var weather = Weather.fromJson(value.data);
        onSuccess(weather);
      });
    } catch (e) {
      onFailure("Get data failed");
    }
  }
}
