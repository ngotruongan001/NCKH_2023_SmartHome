import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';

class LightPage extends StatefulWidget {
  final  String title;
  final  String floor;

  const LightPage({ Key? key, required this.floor, required this.title}): super(key: key);
  @override
  State<LightPage> createState() => _LightPageState();
}
class _LightPageState extends State<LightPage> {
  late bool ledstatuslight1 = false; //boolean value to track LED status, if its ON or OFF
  late bool ledstatuslight2 = false;
  late bool connected; //boolean value to track if WebSocket is connected
  @override
  // void initState() {
  //   // ledstatuslight1 = false; //initially leadstatus is off so its FALSE
  //   // ledstatuslight2 = false;
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
          height: 800,
          // alignment: Alignment.topCenter, //inner widget alignment to center
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50,),
                    Container(
                      child: (ledstatuslight1 == true || ledstatuslight2 == true)
                          ? SizedBox(width: 150, child: Image.asset("assets/icons/on.png"))
                          : SizedBox(
                          width: 150, child: Image.asset("assets/icons/off.png")),
                    ),
                    const SizedBox(height: 40,),
                    SizedBox(
                      height: 400 ,
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: context.watch<ThemeProvider>().cardDashBoard,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children:  [
                                        Text(
                                          "Light 1",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19,
                                              color: context.watch<ThemeProvider>().textColor),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Switch(
                                          activeColor: Colors.deepOrange,
                                          value: ledstatuslight1,
                                          onChanged: (bool val) {
                                            setState(() {
                                              ledstatuslight1 = val;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children:  [
                                        Text(
                                          "70%",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: context.watch<ThemeProvider>().textColor),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.deepOrange,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.deepOrange,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Watt total power consumption",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: context.watch<ThemeProvider>().textColor),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        '12KW/H',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: context.watch<ThemeProvider>().textColor,)
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: context.watch<ThemeProvider>().cardDashBoard,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children:  [
                                        Text(
                                          "Light 2",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19,
                                              color: context.watch<ThemeProvider>().textColor),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Switch(
                                          activeColor: Colors.deepOrange,
                                          value: ledstatuslight2,
                                          onChanged: (bool val) {
                                            setState(() {
                                              ledstatuslight2 = val;
                                            });
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children:  [
                                        Text(
                                          "64%",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: context.watch<ThemeProvider>().textColor),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.deepOrange,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.deepOrange,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Watt total power consumption",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          color: context.watch<ThemeProvider>().textColor),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '9KW/H',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: context.watch<ThemeProvider>().textColor),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),

            ],
          )),
    );
  }
}