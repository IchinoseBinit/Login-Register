import 'package:flutter/material.dart';
import 'package:login_register_first/Components/add_to_do.dart';
import 'package:login_register_first/Components/list_todo.dart';
import 'package:login_register_first/Models/MyUser.dart';
import 'package:login_register_first/Screens/login.dart';
import 'package:login_register_first/services/user_management.dart';
import 'package:login_register_first/Utilities/snackbar.dart';

class Dashboard extends StatefulWidget {
  final MyUser user;

  Dashboard(this.user);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        title: Text("Dashboard"),
        centerTitle: true,
        actions: [
          Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                if (widget.user.permission == "edit") {
                  showModalBottomSheet(
                    isScrollControlled: true,
                      context: ctx,
                      builder: (_) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: GestureDetector(
                            onTap: () {},
                            child: AddToDo(widget.user, ctx),
                            behavior: HitTestBehavior.opaque,
                          ),
                        );
                      });
                } else {
                  MyUtilities.showSnackbar(
                      ctx, "Access Denied, You do not have the edit permission to edit ToDos!");
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        // padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Hi " + widget.user.fullname,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 380,
                          child: ToDoList(widget.user),
                        ),
                        RaisedButton(
                          color: Colors.red,
                          child: Text("Log out",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white)),
                          onPressed: () {
                            UserManagement().signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                ModalRoute.withName('/'));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
