import 'package:flutter/material.dart';
import 'package:login_register_first/Models/User.dart';
import 'package:login_register_first/Screens/login.dart';

class Dashboard extends StatelessWidget {
  final User user;

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
                "Hi " + user.fullname,
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
