import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';
import 'package:smart_home/model/FeedbackModel.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}


Future<FeedbackModel?> createUser(String description) async {
  const apiUrl =
      "https://server-flutter2-ktm.herokuapp.com/v1/api/message/create";
  final response = await http.post(json.decode(apiUrl), body: {
    "description": description,
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;

    return FeedbackModelFromJson(responseString);
  } else {
    return null;
  }
}

class _ReportPageState extends State<ReportPage> {
  final myController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: context.watch<ThemeProvider>().pageBackgroundColor,
            body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xEAF88325),
                Color(0xFFE87114),
              ],
              begin: FractionalOffset(0.0, 1.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              // tileMode: TileMode.clamp
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    "FeedBack",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Container(
                  height: 800,
                  decoration:  BoxDecoration(
                      color: context.watch<ThemeProvider>().backgroundFeedback,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40))),
                  child: Container(
                      child: SingleChildScrollView(
                    child: SizedBox(
                      height: 900,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                    height: 300,
                                    width: 300,
                                    child: Lottie.asset(
                                        'assets/json/feedback.json',
                                        repeat: true)),
                              ),
                              SizedBox(
                                height: 200,
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  textAlign: TextAlign.start,
                                  decoration: const InputDecoration(
                                      fillColor: Colors.deepOrange,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.deepOrange,
                                          width: 2.0,
                                        ),
                                      )),
                                  controller: myController,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepOrange,
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final FeedbackModel? user =
                                          await createUser(myController.text);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                    myController.text = "";
                                  },
                                  child: Center(
                                      child: SizedBox(
                                          height: 50,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Text(
                                                'Submit',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))),
            ],
          ),
        ),
      ),
    )));
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
