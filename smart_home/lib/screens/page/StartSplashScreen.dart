import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/screens/page/Login/Login.dart';


class StartSplashScreen extends StatefulWidget {
  const StartSplashScreen({Key? key}) : super(key: key);

  @override
  State<StartSplashScreen> createState() => _StartSplashScreenState();
}

class _StartSplashScreenState extends State<StartSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 30),
              SizedBox(
                  height: 400,
                  width: 400,
                  child: Lottie.asset('assets/json/logo.json', repeat: false,width: 200,height:100 )),
              const SizedBox(height: 20,),
              const Text(
                "Smart Home",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
