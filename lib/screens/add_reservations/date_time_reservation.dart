import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:national_museum/screens/add_reservations/bulding_reservations.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AddReservation extends StatefulWidget {
  
  static String id = 'add_reservation';
  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {


  DateTime _time = DateTime.now();
  DateTime stringToDate = DateTime.now();
  String converted;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose $converted');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadDate().then((_){
      print('init $converted');
    });

  }

  _setTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('time', _time.toString());
      prefs.setString('date', stringToDate.toString());
    });
  }
  
  _loadDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    converted = prefs.getString('date');
    stringToDate = DateTime.parse(converted);
//    print('${formatDate(stringToDate, [MM, ' ', d, ', ', yyyy])}');
    converted = '${formatDate(stringToDate, [MM, ' ', d, ', ', yyyy])}';
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
                child: ShowDate(date: converted,)),
            SizedBox(
              height: 275.0,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: _time,
                onDateTimeChanged: (dateTime) {
                  print('${dateTime.hour}:${dateTime.minute} ');
                  setState(() {
                    _time = dateTime;
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

class ShowDate extends StatelessWidget {
  final String date;
  ShowDate({this.date});
  @override
  Widget build(BuildContext context) {
    return Text(
      '$date',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.lightBlueAccent,
      ),
    );
  }
}
