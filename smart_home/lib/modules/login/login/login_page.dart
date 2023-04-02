import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/authentication/auth_services.dart';
import 'package:smart_home/modules/login/login/cubit/login_cubit.dart';
import 'package:smart_home/modules/splash_page/FlashScreen.dart';
import 'package:smart_home/modules/login/forgot_password/ForgotPassword.dart';
import 'package:smart_home/modules/login/register/Register.dart';
import 'package:smart_home/string/app_strings.dart';
import 'package:smart_home/themes/app_dimension.dart';
import 'package:smart_home/themes/theme_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map? _userData;
  var bloc = LoginCubit();
  final _formKey = GlobalKey<FormState>();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    bloc.emailController.text = 'ngoctinhxx@gmail.com';
    bloc.passwordController.text = '123456';
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: bloc.emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Vui Lòng Nhập Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Vui lòng nhập email hợp lệ");
          }
          return null;
        },
        onSaved: (newValue) {
          bloc.handleChangeEmailText(newValue ?? '');
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.mail,
            color: Colors.deepOrange,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.deepOrange[100],
          filled: true,
        ));
    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: bloc.passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Mật Khẩu bắt buộc để đăng nhập");
          }
          if (!regex.hasMatch(value)) {
            return ("Nhập mật khẩu hợp lệ(Tối thiểu 6 kí tự)");
          }
        },
        onSaved: (newValue) {
          bloc.handleChangePasswordText(newValue ?? '');
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.vpn_key,
            color: Colors.deepOrange,
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.deepOrange[100],
          filled: true,
          suffixIcon: const Icon(
            Icons.remove_red_eye,
            color: Colors.deepOrange,
          ),
        ));
    final loginButton = InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            bloc.login();
          }
        },
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.loading.tr,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 5.0.r,
                      ),
                      _widgetCircleLoading(height: 18.0.r, width: 18.0.r),
                    ],
                  );
                }
                return Center(
                  child: Text(
                    AppStrings.loginTitle.tr,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ));
    Size size = MediaQuery.of(context).size;
    return BlocConsumer(
        bloc: bloc,
        listener: (context, state) {
          if (state is LoginFailure) {
            Fluttertoast.showToast(msg: state.errorMessage);
          }
          if (state is LoginSuccess) {
            Fluttertoast.showToast(msg: "Login success!!!");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FlashScreen()));
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: DrawClip(),
                          child: Container(
                            height: 280,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xffee4c14), Color(0xffffc371)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 270,
                          width: double.infinity,
                          child: Lottie.asset('assets/json/login.json'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.1, vertical: 10),
                        child: emailField),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.1, vertical: 10),
                        child: passwordField),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1, vertical: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()));
                              },
                              child: const Text(
                                " Forgot Password?",
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            )
                          ]),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.1, vertical: 20),
                        child: loginButton),
                    Center(
                      child: Text(
                        "OR",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: context.watch<ThemeProvider>().textColor),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              bloc.loginFacebook();
                            },
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Lottie.asset('assets/json/facebook.json',
                                    repeat: false)),
                          ),
                          GestureDetector(
                            onTap: () async {
                              // TwitterServicce().signInWithTwitter();
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => FlashScreen()));
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => FlashScreen()));
                            },
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: Lottie.asset('assets/json/twitter2.json',
                                    repeat: false)),
                          ),
                          GestureDetector(
                            onTap: () async {
                              bloc.loginGmail();
                            },
                            child: Container(
                                decoration: const BoxDecoration(),
                                height: 75,
                                width: 75,
                                child: Lottie.asset('assets/json/google.json',
                                    repeat: false)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.1, vertical: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Do not have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      context.watch<ThemeProvider>().textColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                              },
                              child: const Text(
                                " Sign Up",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ),
          ));
        });
  }

  Widget _widgetCircleLoading({
    required double height,
    required double width,
    Color? backgroudColor,
    double? strokeWidth,
  }) {
    return SizedBox(
        width: height,
        height: width,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 4.0.r,
        ));
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.1, size.height - 30);
    path.lineTo(size.width * 0.9, size.height - 30);
    path.lineTo(size.width, size.height - 60);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldCliper) {
    return true;
  }
}
