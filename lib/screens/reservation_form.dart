import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:national_museum/screens/add_reservations/date_time_reservation.dart';
import 'package:national_museum/widgets/main_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

final _fireStore = Firestore.instance;

class ReservationForm extends StatefulWidget {
  static String id = 'reservation';
  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  String selectedDate;
  String converted;
  TextEditingController _eventController;

  @override
  void initState() {
    super.initState();
    _eventController = TextEditingController();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    _getReservations().then((_){
    });
  }

   _setDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('date', selectedDate);
    });
  }

  _loadDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    converted = 'ito na nga ${prefs.getString('date')}';
  }

  _getReservations() async {
    int count = 0;
      await for (var snapshot in _fireStore.collection('records').snapshots()) {
        for (var reservation in snapshot.documents) {
          count++;
          setState(() {
          String com = reservation.data['company'];
          String da = reservation.data['date'];
          String time = reservation.data['time'];
          String nam = reservation.data['name'];
          String ema = reservation.data['email'];
          String con = reservation.data['contact'];
          String eve = da;
          print('$count');
          if(_events[DateTime.parse(da)] != null) {
            _events[DateTime.parse(da)].add(eve);
          }
          else {
            _events[DateTime.parse(da)] = [eve];
          }

          });

        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 24.0, right: 24.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                selectedDate = _controller.selectedDay.toString();
                await _setDate();
                await _loadDate();
                print(_events[_controller.selectedDay]);
                showModalBottomSheet(

                    context: context, builder: (context) => AddReservation());
              },
            ),
          ),
          key: scaffoldKey,
          drawer: MainDrawer(),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: TableCalendar(
                          calendarController: _controller,
                          events: _events,
                          calendarStyle: CalendarStyle(markersColor: Colors.white),
                          onDaySelected: (date, events) {
                            setState(()  {
                              _selectedEvents = events;
                              print(_events[_controller.selectedDay]);
                            });
                          },
                        ),
                      ),
                      ..._selectedEvents.map((event) => Column(
                        children: <Widget>[
                          ListTile(title: Text(event),
                          onTap: () {
                            print(event);
                          },),
                        ],
                      ))
                    ],
                  ),
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
      ),
    );
  }
}
