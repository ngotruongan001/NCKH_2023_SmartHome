import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';

class TopButton extends StatefulWidget {
  const TopButton({Key? key, required this.handleClick, required this.setId}) : super(key: key);
  final Function handleClick;
  final num setId;
  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 20, 0, 0),
      height: 65,
      width: 950,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: ()=>{
              widget.handleClick(0)
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.setId == 0? context.watch<ThemeProvider>().backgroundClick: context.watch<ThemeProvider>().backgroundTopBar,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/temp.png",
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                  color: widget.setId == 0? Colors.white:  Colors.deepOrange,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: ()=>{
              widget.handleClick(1)
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.setId == 1? context.watch<ThemeProvider>().backgroundClick: context.watch<ThemeProvider>().backgroundTopBar,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/humi.png",
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                  color: widget.setId == 1? Colors.white: Colors.deepOrange,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: ()=>{
              widget.handleClick(2)
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.setId == 2? context.watch<ThemeProvider>().backgroundClick: context.watch<ThemeProvider>().backgroundTopBar,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/light.png",
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                  color: widget.setId == 2? Colors.white: Colors.deepOrange,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: ()=>{
              widget.handleClick(3)
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.setId == 3? context.watch<ThemeProvider>().backgroundClick: context.watch<ThemeProvider>().backgroundTopBar,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/fire.png",
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                  color: widget.setId == 3? Colors.white: Colors.deepOrange,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: ()=>{
              widget.handleClick(4)
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.setId == 4? context.watch<ThemeProvider>().backgroundClick: context.watch<ThemeProvider>().backgroundTopBar,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/anti-theft.png",
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                  color: widget.setId == 4? Colors.white: Colors.deepOrange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
