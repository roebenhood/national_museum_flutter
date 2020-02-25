import 'package:flutter/material.dart';
import 'package:national_museum/screens/add_reservations/bulding_reservations.dart';
import 'package:national_museum/screens/dashboard_screen.dart';
import 'package:national_museum/screens/reservation_form.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Essential Links'),
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          ListTile(
            title: Text(
              'Dashboard',
              style: TextStyle(fontSize: 18.0),
            ),
            leading: Icon(
              Icons.home,
              size: 28.0,
            ),
            onTap: () {
              //do something here on Dashboard
              print('this is dashboard');
              Navigator.pushReplacementNamed(context, DashboardScreen.id);
            },
          ),
          ListTile(
            title: Text('Reservation',
            style: TextStyle(fontSize: 18.0),),
            leading: Icon(Icons.calendar_today),
            onTap: () {
              // do something here on reservation
              print('this is reservation');
              Navigator.pushReplacementNamed(context, ReservationForm.id);
            },
          ),
          ListTile(
            title: Text('Visitors Log',
              style: TextStyle(fontSize: 18.0),),
            leading: Icon(Icons.import_contacts),
            onTap: () {
              // do something here on reservation
              print('this is visitors log');
            },
          ),
          ListTile(
            title: Text('Survey',
              style: TextStyle(fontSize: 18.0),),
            leading: Icon(Icons.star),
            onTap: () {
              // do something here on reservation
              print('this is survey');
            },
          ),
          ListTile(
            title: Text('Billing',
              style: TextStyle(fontSize: 18.0),),
            leading: Icon(Icons.receipt),
            onTap: () {
              // do something here on reservation
              print('this is billing');
            },
          ),
          ListTile(
            title: Text('Accounts',
              style: TextStyle(fontSize: 18.0),),
            leading: Icon(Icons.account_circle),
            onTap: () {
              // do something here on reservation
              print('this is accounts');
            },
          ),
          ListTile(
            title: Text('Reports',
              style: TextStyle(fontSize: 18.0),),
            leading: Icon(Icons.report),
            onTap: () {
              // do something here on reservation
              print('this is reports');
            },
          ),
        ],
      ),
    );
  }
}

