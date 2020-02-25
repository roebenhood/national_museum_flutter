import 'package:flutter/material.dart';
import 'package:national_museum/screens/add_reservations/date_reservation.dart';

class VisitorReservation extends StatefulWidget {
  static String id = 'visitor';
  @override
  _VisitorReservationState createState() => _VisitorReservationState();
}

class _VisitorReservationState extends State<VisitorReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 24.0, right: 24.0),
        child: FloatingActionButton(
          child: Icon(Icons.calendar_today),
          onPressed: (){
            showModalBottomSheet(

                context: context, builder: (context) => DateReservation());
          },
        )
      ),
    );
  }
}

