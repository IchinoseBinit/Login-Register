import 'package:flutter/material.dart';
import 'package:login_register_first/Screens/register.dart';
import 'package:login_register_first/Utilities/snackbar.dart';
import 'package:login_register_first/services/user_management.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loginValidate(BuildContext ctx, String username, String pass) {
    if (username == "" || pass == "") {
      MyUtilities.showSnackbar(ctx, "Please input all the details");
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
                    hintText: ' Enter your Email Address',
                    labelText: 'Email *',
                  ),
                  controller: _emailController,
                  onSaved: (String value) {
                    var username = value;
                    print(username);
                  },
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Please input your email address';
                    } else if (value.trim().length < 4) {
                      return 'Email Address contains more than 4 letters.';
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
                    if (_loginValidate(ctx, _emailController.text.trim(),
                        _passwordController.text.trim())) {
                      UserManagement().signIn(_emailController.text.trim(),
                          _passwordController.text.trim(), ctx);
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
