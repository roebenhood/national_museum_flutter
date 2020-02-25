import 'package:flutter/material.dart';
import 'package:national_museum/screens/add_reservations/contact_details.dart';
import 'package:national_museum/screens/add_reservations/date_reservation.dart';
import 'package:national_museum/screens/add_reservations/date_time_reservation.dart';
import 'package:national_museum/screens/add_reservations/bulding_reservations.dart';
import 'package:national_museum/screens/dashboard_screen.dart';
import 'package:national_museum/screens/login_screen.dart';
import 'package:national_museum/screens/registration_screen.dart';
import 'package:national_museum/screens/reservation_form.dart';
import 'package:national_museum/screens/visitor_reservation.dart';
import 'package:national_museum/screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
      routes: {
        DashboardScreen.id: (context) => DashboardScreen(),
        ReservationForm.id: (context) => ReservationForm(),
        AddReservation.id: (context) => AddReservation(),
        AddBuildingReservations.id: (context) => AddBuildingReservations(),
        AddContactDetails.id: (context) => AddContactDetails(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        VisitorReservation.id: (context) => VisitorReservation(),
        DateReservation.id: (context) => DateReservation(),

      },
      initialRoute: WelcomeScreen.id,
    );
  }
}
