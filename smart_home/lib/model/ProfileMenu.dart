import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;
  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: context.watch<ThemeProvider>().cardProfileCorlor,
        ),
        onPressed: widget.press,
        child: Row(
          children: [
            SvgPicture.asset(
              widget.icon,
              color: context.watch<ThemeProvider>().primaryTextColor,
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: 15,color:context.watch<ThemeProvider>().textColor ),
                )),
            Icon(Icons.arrow_forward_ios,color: context.watch<ThemeProvider>().primaryTextColor,),
          ],
        ),
      ),
    );
  }
}