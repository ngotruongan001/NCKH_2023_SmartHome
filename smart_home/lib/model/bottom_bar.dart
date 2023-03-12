import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';
import 'package:smart_home/screens/page/DashBoard.dart';
import 'package:smart_home/screens/page/Home.dart';
import 'package:smart_home/screens/page/Notification.dart';
import 'package:smart_home/screens/page/Profile.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:smart_home/screens/page/WeatherHome.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<BottomBar> {
  int _selectedIndex = 0;

  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = 0;
  }

  void _onItemTapped(int? index) {
    setState(() {
      _selectedIndex = index!;
    });
  }

  static final List<Widget> _widgetOptions = [
    const MyHomePage(),
    DashBoard(),
    const NotificationPage(key: null,),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  WeatherHome()));
        },
        child: Lottie.asset('assets/json/weather.json'),
        backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BubbleBottomBar(
        hasNotch: true, //new
        hasInk: true,
        backgroundColor: context.watch<ThemeProvider>().pageBackgroundColor,
        fabLocation: BubbleBottomBarFabLocation.end,
        opacity: .2,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ), //border radius doesn't work when the notch is enabled.
        elevation: 8,
        // tilesPadding: EdgeInsets.symmetric(
        //   vertical: 8.0,
        // ),
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
            icon: Icon(
              Icons.home,
              color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
            ),
            activeIcon: Icon(
              Icons.home,
              color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
            ),
            title: Text("Home"),
          ),
          BubbleBottomBarItem(
              backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
              icon: Icon(
                Icons.app_shortcut_sharp,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              activeIcon: Icon(
                Icons.app_shortcut_sharp,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              title: Text("Dashboard")),
          BubbleBottomBarItem(
            // showBadge: true,
            // badge: Text("5"),
            // badgeColor: Colors.transparent,
              backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
              icon: Icon(
                Icons.notifications,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              activeIcon: Icon(
                Icons.notifications,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              title: Text("Notify")),
          BubbleBottomBarItem(
              backgroundColor: context.watch<ThemeProvider>().bubblebackgroundColor,
              icon: Icon(
                Icons.person,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              activeIcon: Icon(
                Icons.person,
                color: context.watch<ThemeProvider>().bubbleBottomBarIcon,
              ),
              title: Text("Profile"))
        ],
      ),
    );
  }
}