import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:national_museum/screens/reservation_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _fireStore = Firestore.instance;

class AddContactDetails extends StatefulWidget {

  static String id = 'add_contact_details';
  @override
  _AddContactDetailsState createState() => _AddContactDetailsState();
}

class _AddContactDetailsState extends State<AddContactDetails> {
  String _time, _date;
  bool _planetarium,_nh, _fa, _na;

  final companyController = TextEditingController();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final paxController = TextEditingController();
  String company, name, contactNumber, email,_pax;


  @override
  void initState() {
    super.initState();
  }

  _loadDateTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _date = prefs.getString('date');
      _time = prefs.getString('time');
      print('last screen $_date');
      _planetarium = prefs.getBool('planetarium');
      _na = prefs.getBool('na');
      _nh = prefs.getBool('nh');
      _fa = prefs.getBool('fa');
      name = prefs.getString('name');
      company = prefs.getString('company');
      contactNumber = prefs.get('contactNumber');
      email = prefs.getString('email');
      _pax = prefs.getString('pax');
    });
  }

  _saveContactDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('name', name);
      prefs.setString('company', company);
      prefs.setString('contactNumber', contactNumber);
      prefs.setString('email', email);
      prefs.setString('pax', _pax);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: companyController,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  onChanged: (value) {
                    company = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      hintText: 'Company Name',
                      labelText: 'School | Institution | Group',
                      labelStyle: TextStyle(fontSize: 24.0),
                      border: InputBorder.none),
                ),
                SizedBox(height: 20.0,),
                TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      hintText: 'Fullname',
                      labelText: 'Contact Person',
                      labelStyle: TextStyle(fontSize: 24.0),
                      border: InputBorder.none),
                ),
                SizedBox(height: 20.0,),
                TextField(
                  controller: contactController,
                  keyboardType: TextInputType.numberWithOptions(),
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  onChanged: (value) {
                    contactNumber = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(fontSize: 24.0),
                      border: InputBorder.none),
                ),
                SizedBox(height: 20.0,),
                TextField(
                  controller: emailController,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 24.0),
                      border: InputBorder.none),
                ),
                SizedBox(height: 20.0,),
                TextField(
                  controller: paxController,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (value) {
                    _pax = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      labelText: 'Pax',
                      labelStyle: TextStyle(fontSize: 24.0),
                      border: InputBorder.none),
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
//                      Navigator.pop(context);
                    await _saveContactDetails();
                    await _loadDateTime();
                    _fireStore.collection('records').add({
                      'date': _date,
                      'time': _time,
                      'planetarium': _planetarium,
                      'na': _na,
                      'nh': _nh,
                      'fa': _fa,
                      'company': company,
                      'name': name,
                      'contact': contactNumber,
                      'email': email,
                      'pax': _pax
                    });
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                    Navigator.pushNamed(context, ReservationForm.id);

                    },
                  ),
                ),
              ],
            )),

      ),
    );
  }
}
