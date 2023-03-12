import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/theme_provider.dart';
import 'package:smart_home/model/NotificationTiles.dart';
import 'package:smart_home/viewmodel/DataProvider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    context.read<DataProvider>().fetchApiMessage();
  }
  @override
  Widget build(BuildContext context) {
    var a = context.watch<ThemeProvider>();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                  decoration: BoxDecoration(
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Notification",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,
                                color: a.textColor
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1000,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: context.watch<DataProvider>().list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NotificationTiles(
                        title: context.watch<DataProvider>().list[index].title,
                        subtitle: context.watch<DataProvider>().list[index].description,
                        enable: true,
                        status: context.watch<DataProvider>().list[index].status,
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => NotificationPage())),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}