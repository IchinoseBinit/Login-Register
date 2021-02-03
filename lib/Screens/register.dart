import 'package:flutter/material.dart';
import 'package:login_register_first/Screens/login.dart';
import 'package:login_register_first/Utilities/snackbar.dart';
import 'package:login_register_first/services/user_management.dart';

class RegisterScreen extends StatelessWidget {
  final _fullnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();

  void _register(BuildContext ctx) {
    var fullname = _fullnameController.text.trim();
    var username = _usernameController.text.trim();
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();
    var repassword = _repasswordController.text.trim();
    if (fullname == "" ||
        username == "" ||
        email == "" ||
        password == "" ||
        repassword == "") {
      MyUtilities.showSnackbar(ctx, "Please input all the details");
    } 
    else if (password != repassword) {
      MyUtilities.showSnackbar(ctx, "Password does not match");
    } else if (fullname.contains(new RegExp(r'[0-9]'))) {
      MyUtilities.showSnackbar(ctx, "Please input alphabetical value in Full Name");
    }
    else{
      try {
        UserManagement().registerUser(fullname, email, username, password, ctx);
      }
      catch(e){
        MyUtilities.showSnackbar(ctx, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(
          top: 100,
        ),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Center(
              child: Text(
                "Register Form",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 300,
              child: Form(
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.perm_contact_cal),
                    hintText: ' Enter your Full Name',
                    labelText: 'Full Name *',
                  ),
                  controller: _fullnameController,
                  onSaved: (String value) {
                    var username = value;
                    print(username);
                  },
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Please input your Full Name';
                    } else if (value.trim().length < 4) {
                      return 'Full Name contains more than 4 letters.';
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
                    icon: Icon(Icons.email),
                    hintText: ' Enter your Email Address',
                    labelText: 'Email Address *',
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
            SizedBox(
              height: 20,
            ),
            Container(
              width: 300,
              child: Form(
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: ' Re-enter your Password',
                    labelText: 'Re-type Password *',
                    suffixIcon: Icon(
                      Icons.visibility_off,
                    ),
                  ),
                  controller: _repasswordController,
                  obscureText: true,
                  onSaved: (String value) {
                    var username = value;
                    print(username);
                  },
                  validator: (String value) {
                    if (value.trim().isEmpty) {
                      return 'Please input your repassword';
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
                  color: Colors.orange,
                  child: Text("Register",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  onPressed: () {
                    _register(ctx);
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(
                "Already have an account? ",
              ),
              GestureDetector(
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.lightBlue, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }),
            ]),
          ]),
        ),
      ),
    );
  }
}
