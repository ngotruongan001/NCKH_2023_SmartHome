import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/modules/login/login/login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // string for displaying the error Message
  String? errorMessage;
  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final TextEditingController emailController = TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    //email field
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
          prefixIcon: const Icon(Icons.mail,color: Colors.deepOrange,),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.deepOrange[100],
          filled: true,
        ));

    final forgotButton =  ElevatedButton(
        onPressed: () async {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text).then((value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
          });
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
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1, vertical: 10),
                    child: emailField
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1, vertical: 20),
                    child: forgotButton,
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size){
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width*0.1, size.height-30);
    path.lineTo(size.width*0.9, size.height-30);
    path.lineTo(size.width, size.height-60);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldCliper){
    return true;
  }
}
