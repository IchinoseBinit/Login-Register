import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_register_first/Models/MyUser.dart';
import 'package:login_register_first/Screens/admin_dashboard.dart';
import 'package:login_register_first/Screens/dashboard.dart';
import 'package:login_register_first/Screens/login.dart';
import 'package:login_register_first/Utilities/snackbar.dart';

class UserManagement {
  UserCredential _userCredential;
  CollectionReference users;
  UserManagement() {
    users = FirebaseFirestore.instance.collection('users');
  }

  signIn(String email, String password, BuildContext ctx) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((x) {
      if (x != null) {
        _userCredential = x;
        authorizeAdmin(ctx, _userCredential);
      }
    }).catchError(
      (e) => MyUtilities.showSnackbar(ctx, "Incorrect Username or Password"),
    );
  }

  registerUser(String fullName, String email, String userName, String password,
      BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((x) {
      if (x != null) {
        String userId = x.user.uid;
        registerDetails(email, fullName, userId, userName, "user", context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  registerDetails(String email, String fullName, String uId, String userName,
      String role, BuildContext ctx) {
    users
        .doc(uId)
        .set({
          'email_address': email,
          'full_name': fullName, // John Doe
          'u_id': uId, // Stokes and Sons
          'user_name': userName,
          'role': role,
          'permission': 'view'
        })
        .then((value) => MyUtilities.showSnackbar(ctx, "User Added"))
        .catchError((error) =>
            MyUtilities.showSnackbar(ctx, "Failed to add user: $error"));
  }

  Stream<QuerySnapshot> getAllUsers() {
    return users.snapshots();
  }

  editUser(Map<String, dynamic> maps, BuildContext ctx) {
    users.doc(maps['u_id']).update(
      {
        "role": maps['role'],
        "permission": maps['permission'],
        "full_name": maps['full_name']
      },
    ).then((_) {
      Navigator.pushAndRemoveUntil(
          ctx,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
          ModalRoute.withName('/admin'));
    }).catchError(
      (x) => print(x),
    );
  }

  deleteUser(String id, BuildContext ctx){
    MyUtilities.showSnackbar(ctx, "Successfully deleted the User!");
    users.doc(id).delete().then((_) {
          Navigator.pushAndRemoveUntil(
          ctx,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
          ModalRoute.withName('/admin'));
    });
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    return users.doc(uid).get();
  }

  void authorizeAdmin(BuildContext ctx, UserCredential user) {
    // var firebaseUser =  FirebaseAuth.instance.;
    users.doc(user.user.uid).get().then((value) {
      if (value['role'] == 'admin') {
        // CircularProgressIndicator cpi = new CircularProgressIndicator();
        Navigator.push(
            ctx, MaterialPageRoute(builder: (context) => AdminDashboard()));
      } else {
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) => Dashboard(MyUser.fromMap(value.data())),
          ),
        );
      }
    });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
