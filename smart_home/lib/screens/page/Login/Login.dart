import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/auth/auth_service.dart';
import 'package:smart_home/constants/theme_provider.dart';

import 'package:smart_home/screens/page/FlashScreen.dart';
import 'package:smart_home/screens/page/Login/ForgotPassword.dart';
import 'package:smart_home/screens/page/Login/Register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map? _userData;
  late String email, pass;

  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
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
        onSaved: (value) {
          emailController.text = value!;
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
        controller: passwordController,
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
        onSaved: (value) {
          passwordController.text = value!;
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

    final loginButton = ElevatedButton(
        onPressed: () {
          print(emailController.text);
          signIn(emailController.text, passwordController.text);
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
            width: 400,
            child: const Center(
              child: Text(
                "Submit",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ));

    Size size = MediaQuery.of(context).size;

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
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
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
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final result = await FacebookAuth.i
                            .login(permissions: ["public_profile", "email"]);
                        if (result.status == LoginStatus.success) {
                          final requestData = await FacebookAuth.i
                              .getUserData(fields: "email, name");
                          setState(() {
                            _userData = requestData;
                          });
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FlashScreen()));
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
                      },
                      child: SizedBox(
                          height: 80,
                          width: 80,
                          child: Lottie.asset('assets/json/twitter2.json',
                              repeat: false)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseServices().signInWithGoogle();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FlashScreen()));
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
                            color: context.watch<ThemeProvider>().textColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
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
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Đăng nhập thành công"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => FlashScreen())),
                });
      } on FirebaseAuthException catch (error) {
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
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
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
