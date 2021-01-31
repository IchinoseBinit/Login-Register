import 'package:flutter/material.dart';
import 'package:login_register_first/Models/User.dart';
import 'package:login_register_first/Screens/Dashboard.dart';
import 'package:login_register_first/Screens/register.dart';
import 'package:login_register_first/Utilities/snackbar.dart';
import 'package:login_register_first/data/connector_database.dart';

class LoginScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _loginComplete(BuildContext ctx, User x) {
    if (x != null) {
      Navigator.push(
          ctx, MaterialPageRoute(builder: (context) => Dashboard(x)));
    }else{
      showDialog(
          context: ctx,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Incorrect Credentials"),
              title: Text("Please enter valid credentials"),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Close me!',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    
    }
  }

  void _login(BuildContext context, String username, String pass) {
    ConnectDatabase cdb = new ConnectDatabase();
    cdb.loginUser(username, pass).then((x) => _loginComplete(context, x));
  }

  bool _loginValidate(BuildContext ctx, String username, String pass) {
    if (username == "" || pass == "") {
      MySnackbar.showSnackbar(ctx, "Please input all the details");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(
          top: 200,
        ),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Center(
              child: Text(
                "Welcome to Login Form",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              width: 300,
              child: Form(
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: ' Enter your Username',
                    labelText: 'Username *',
                  ),
                  controller: _usernameController,
                  onSaved: (String value) {
                    var username = value;
                    print(username);
                  },
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Please input your username';
                    } else if (value.trim().length < 4) {
                      return 'Username contains more than 4 letters.';
                    }
                    return "";
                  },
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 300,
              child: Form(
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: ' Enter your Password',
                    labelText: 'Password *',
                    suffixIcon: Icon(
                      Icons.visibility_off,
                    ),
                  ),
                  controller: _passwordController,
                  obscureText: true,
                  onSaved: (String value) {
                    var username = value;
                    print(username);
                  },
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Please input your password';
                    } else if (value.trim().length < 8) {
                      return 'Password contains more than 4 letters.';
                    }
                    return "";
                  },
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 180,
              height: 60,
              child: Builder(
                builder: (ctx) => RaisedButton(
                  color: Colors.lightBlue,
                  child: Text("Log In",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  onPressed: () {
                    if (_loginValidate(ctx, _usernameController.text.trim(),
                        _passwordController.text.trim())) {
                      _login(context, _usernameController.text.trim(),
                          _passwordController.text.trim());
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                "Don't have an account? ",
              ),
              GestureDetector(
                  child: Text(
                    "Create one",
                    style: TextStyle(
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  }),
            ]),
          ]),
        ),
      ),
    );
  }
}
