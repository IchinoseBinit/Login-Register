import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_register_first/Models/MyUser.dart';
import 'package:login_register_first/Screens/user_details.dart';
import 'package:login_register_first/services/user_management.dart';

class AdminDashboard extends StatelessWidget {
  _editUser(String id, BuildContext ctx) {
    UserManagement().getUser(id).then((doc) {
      // print(doc['email_address']);
      // MyUser asb = MyUser.fromMap(doc);
      // print(asb.email);
      Navigator.push(
          ctx,
          MaterialPageRoute(
              builder: (context) => UserDetails(MyUser.fromMap(doc))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Dashboard"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 70,
                child: Center(
                  child: Text(
                    "All Users",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 360,
                child: StreamBuilder(
                  stream: UserManagement().getAllUsers(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView(
                      children: snapshot.data.docs.map((document) {
                        return Center(
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 5,
                            ),
                            child: ListTile(
                              title: Text(document['full_name'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                              subtitle: Text("Role: " +
                                  document['role'] +
                                  ", Permission: " +
                                  document['permission']),
                              trailing: MediaQuery.of(context).size.width > 500
                                  ? FlatButton.icon(
                                      icon: Icon(Icons.edit),
                                      onPressed: () =>
                                          _editUser(document.id, context),
                                      label: Text('Edit'),
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () =>
                                          _editUser(document.id, context),
                                    ),
                            ),
                          ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width / 1.2,
                          //   height: MediaQuery.of(context).size.height/3,
                          //   child: Text("Title: "+document['title']),
                          // ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
