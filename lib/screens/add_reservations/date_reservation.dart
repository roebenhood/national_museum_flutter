import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:national_museum/screens/add_reservations/bulding_reservations.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DateReservation extends StatefulWidget {

  static String id = 'date_reservation';
  @override
  _DateReservationState createState() => _DateReservationState();
}

class _DateReservationState extends State<DateReservation> {


  DateTime _dateTime = DateTime.now();
  DateTime stringToDate = DateTime.now();

  _setTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('time', _dateTime.toString());
      prefs.setString('date', stringToDate.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff141414),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Text(
                  'Select Date and Time',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.lightBlueAccent,
                  ),
                )),
            SizedBox(
              height: 275.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: _dateTime,
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    _dateTime = dateTime;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 10.0),
              child: ButtonTheme(
                height: 45.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.lightBlueAccent,
                  onPressed: () async {
                    await _setTime();
////                    await _loadDateAndTime();
//                    print(formatDate(_dateTime, [hh,':',mm,' ', am]));
//                    print(formatDate(_dateTime, [DD]));
//                    print(formatDate(_dateTime, [MM, ' ', d, ', ', yyyy]));
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AddBuildingReservations.id);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

