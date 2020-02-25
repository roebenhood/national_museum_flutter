import 'package:flutter/material.dart';
import 'package:national_museum/widgets/main_drawer.dart';
import 'package:table_calendar/table_calendar.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class DashboardScreen extends StatefulWidget {
  static String id = 'dashboard';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CalendarController _controller;
  Map<DateTime,List<dynamic>> _events;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 24.0, right: 24.0),
          ),
          key: scaffoldKey,
          drawer: MainDrawer(),
          body: Stack(
            children: <Widget>[
              Center(
                  child: new Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: 75.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('THIS IS DASHBOARD')
                            ],
                          ),
                        ),
                      ),

                    ],
                  )),
              Positioned(
                left: 10,
                top: 20,
                child: IconButton(
                    icon: Icon(Icons.menu),
                    iconSize: 32.0,
                    onPressed: () => scaffoldKey.currentState.openDrawer()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
