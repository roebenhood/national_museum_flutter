import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:national_museum/components/rounded_button.dart';
import 'package:national_museum/constants.dart';
import 'package:national_museum/screens/welcome_screen.dart';

final String nmpLogo = 'images/nmp.svg';
final Widget svg = SvgPicture.asset(nmpLogo);

class RegistrationScreen extends StatefulWidget {
  static String id = 'register';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  String email;
  String password;
  bool showSpinner = false;
  bool enableFields = true;
  FocusNode focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: svg,
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                focusNode: focusNode,
                enabled: enableFields,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                enabled: enableFields,
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                    enableFields = false;
                    focusNode.dispose();
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      _fireStore.collection('users').add({
                        'email': email,
                        'password': password
                      });
                      Navigator.pushNamed(context, WelcomeScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                      enableFields = true;
                    });
                  } catch (e) {
                    print(e);
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
