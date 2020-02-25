
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:national_museum/screens/add_reservations/contact_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../reservation_form.dart';

class AddBuildingReservations extends StatefulWidget {
  final DateTime dt;
  AddBuildingReservations({this.dt});
  static String id = 'add_reservation_details';
  @override
  _AddBuildingReservationsState createState() => _AddBuildingReservationsState();
}

class _AddBuildingReservationsState extends State<AddBuildingReservations> {
  String _time;
  bool _planetarium = false;
  bool _nh = false;
  bool _fa = false;
  bool _na = false;

  @override
  void initState() {
    super.initState();
    _loadDateTime();

  }
  _loadDateTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _time = prefs.getString('time');
    });
  }
  _saveBuildings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('planetarium', _planetarium);
      prefs.setBool('nh', _nh);
      prefs.setBool('fa', _fa);
      prefs.setBool('na', _na);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff141414),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Text('National Planetarium'),
                trailing: Checkbox(
                  onChanged: (bool value) {
                    setState(() {
                      _planetarium = value;
                    });
                  },
                  value: _planetarium,
                ),
              ),
              ListTile(
                leading: Text('National History'),
                trailing: Checkbox(
                  onChanged: (bool value) {
                    setState(() {
                      _nh = value;
                    });
                  },
                  value: _nh,
                ),
              ),
              ListTile(
                leading: Text('National Arts Gallery'),
                trailing: Checkbox(
                  onChanged: (bool value) {
                    setState(() {
                      _na = value;
                    });
                  },
                  value: _na,
                ),
              ),
              ListTile(
                leading: Text('Fine Arts'),
                trailing: Checkbox(
                  onChanged: (bool value) {
                    setState(() {
                      _fa = value;
                    });
                  },
                  value: _fa,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ButtonTheme(
                        height: 45.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.lightBlueAccent,
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, ReservationForm.id);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ButtonTheme(
                        height: 45.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.lightBlueAccent,
                          onPressed: () async {
                            await _loadDateTime();
                            await _saveBuildings();
                            Navigator.pop(context);
                            Navigator.pushNamed(context, AddContactDetails.id);
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
