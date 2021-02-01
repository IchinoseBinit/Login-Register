import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register_first/Screens/login.dart';
import 'package:login_register_first/services/user_management.dart';

class Dashboard extends StatelessWidget {
  final UserCredential user;

  Dashboard(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 100),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Hi ",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.all(20),
                child: RaisedButton(
                  color: Colors.red,
                  child: Text("Log out",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  onPressed: () {
                    UserManagement().signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        ModalRoute.withName('/'));
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
