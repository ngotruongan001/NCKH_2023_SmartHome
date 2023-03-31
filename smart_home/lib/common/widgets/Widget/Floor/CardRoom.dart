import 'package:flutter/material.dart';
import 'package:smart_home/modules/room/Room.dart';

class CardRoom extends StatefulWidget {
  final  String title;
  final  num temperature;
  final  num humidity;
  final  String image;
  final  String floor;

  const CardRoom({ Key? key,required this.title, required this.temperature, required this.humidity, required this.image, required this.floor}): super(key: key);

  @override
  State<CardRoom> createState() => _CardRoomState();
}

class _CardRoomState extends State<CardRoom> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>  Room(
              floor: widget.floor,
              title: widget.title,
            )));
      },
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.image,
                width: 180.0,
                height: 200.0,
                fit: BoxFit.cover,
              )),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
                backgroundBlendMode: BlendMode.darken
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 0, right: 8, top: 8, bottom: 8),
                    child:  Text("${widget.title}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Temp",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${widget.temperature}°C",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Humi",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                                const SizedBox(height: 10),
                                Text(" ${widget.humidity}%",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14)),
                              ],
                            ),
                            Column(
                              children: const [
                                Text("Devi",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black)),
                                SizedBox(height: 10),
                                Text("5",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}