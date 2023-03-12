import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_home/model/bottom_bar.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  void initState(){
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomBar()));
    });
    super.initState();

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: 300,
                child: Lottie.asset('assets/json/loading2.json')),
            SizedBox(height: 30),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.deepOrange),
            ),
          ],
        ),
      ),
    );
  }
}
