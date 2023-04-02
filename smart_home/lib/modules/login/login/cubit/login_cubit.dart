import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/data/respository.dart';
import 'package:smart_home/modules/login/login/models/request_user.dart';
import 'package:smart_home/modules/login/login/models/response_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var repo = Repository();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void loginFacebook() async {
    emit(LoginLoading());
    await repo.loginFacebook(
      handleLoginSuccess,
      handleLoginFailed,
    );
  }

  void loginGmail() async {
    emit(LoginLoading());
    await repo.loginGmail(
      handleLoginSuccess,
      handleLoginFailed,
    );
  }

  void login() async {
    emit(LoginLoading());
    var requestUser = RequestUser(
      email: emailController.text,
      password: passwordController.text,
    );
    await repo.login(
      handleLoginSuccess,
      handleLoginFailed,
      requestUser: requestUser,
    );
  }

  void handleLoginSuccess() {
    print("Login success!!");
    emit(LoginSuccess());
  }

  void handleLoginFailed(String errorMessage) {
    print("Login failed!!");
    emit(LoginFailure(errorMessage));
  }

  void handleChangeEmailText(String value) {
    emailController.text = value;
  }

  void handleChangePasswordText(String value) {
    passwordController.text = value;
  }
}
