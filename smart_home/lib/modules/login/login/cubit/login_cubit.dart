import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/modules/login/login/models/response_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  ResponseUser data = ResponseUser();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void login() async {
    emit(LoginLoading());
    // var loginRepo = Repository();
    // var reqUser = RequestUser(
    //   username: phoneController.text,
    //   password: passwordController.text,
    // );
    // await loginRepo.login(
    //   handleLoginSuccess,
    //   handleLoginFailed,
    //   requestUser: reqUser,
    // );
  }

  void handleLoginSuccess(ResponseUser user) {
    data = user;

    emit(LoginSuccess(data));
  }

  void handleLoginFailed(String errorMessage) {
    emit(LoginFailure(errorMessage));
  }

}
