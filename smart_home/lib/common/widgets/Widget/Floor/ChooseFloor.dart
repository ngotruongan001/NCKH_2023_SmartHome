import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/themes/theme_provider.dart';

class ChooseFloor extends StatefulWidget {
  const ChooseFloor({Key? key, required this.handleClick, required this.setId}) : super(key: key);
  final Function(int) handleClick;
  final num setId;
  @override
  State<ChooseFloor> createState() => _ChooseFloorState();
}


class _ChooseFloorState extends State<ChooseFloor> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
      height: 30,
      width: 900,
      child: Row(
        // This next line does the trick.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: ()=>{
              widget.handleClick(0)
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:widget.setId == 0? context.watch<ThemeProvider>().backgroundClick: context.watch<ThemeProvider>().backgroundNonClick,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 80,
              child: Text(
                "Floor 1",
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,
                  color: widget.setId == 0?  context.watch<ThemeProvider>().textClickColor:  context.watch<ThemeProvider>().textNonClickColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: ()=>{
              widget.handleClick(1)
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.setId == 1? context.watch<ThemeProvider>().backgroundClick: context.watch<ThemeProvider>().backgroundNonClick,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 80,
              child: Text(
                "Floor 2",
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,
                    color: widget.setId == 1? context.watch<ThemeProvider>().textClickColor:   context.watch<ThemeProvider>().textNonClickColor),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: ()=>{
              widget.handleClick(2)
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.setId == 2? context.watch<ThemeProvider>().backgroundClick: context.watch<ThemeProvider>().backgroundNonClick,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 80,
              child: Text(
                "Floor 3",
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold
                    ,  color: widget.setId == 2?  context.watch<ThemeProvider>().textClickColor:   context.watch<ThemeProvider>().textNonClickColor),
              ),
            ),
          ),
          const SizedBox(
            width: 30,
          ),

        ],
      ),
    );
  }
}