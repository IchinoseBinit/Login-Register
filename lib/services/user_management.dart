import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_register_first/Screens/AdminDashboard.dart';
import 'package:login_register_first/Screens/Dashboard.dart';
import 'package:login_register_first/Screens/login.dart';
import 'package:login_register_first/Utilities/snackbar.dart';

class UserManagement {
  String uid;
  UserCredential _userCredential;
  signIn(String email, String password, BuildContext ctx) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((x) {
      if (x != null) {
        _userCredential = x;
        authorizeAdmin(ctx, _userCredential);
      }
    });
  }

  registerUser(String fullName, String email, String userName, String password,
      BuildContext context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((x) {
      if (x != null) {
        String userId = x.user.uid;
        registerDetails(fullName, userId, userName, "user", context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  registerDetails(String fullName, String uId, String userName, String role, BuildContext ctx) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    users
        .doc(uId)
        .set({
          'full_name': fullName, // John Doe
          'u_id': uId, // Stokes and Sons
          'user_name': userName,
          'role': role
        })
        .then((value) => print("User Added"))
        .catchError((error) => MySnackbar.showSnackbar(ctx, "Failed to add user: $error"));
  }

  void authorizeAdmin(BuildContext ctx, UserCredential user) {
    // var firebaseUser =  FirebaseAuth.instance.;
    FirebaseFirestore.instance.collection("users").doc(user.user.uid).get().then((value) {
      if (value['role'] == 'admin') {
        // CircularProgressIndicator cpi = new CircularProgressIndicator();
        Navigator.push(
            ctx, MaterialPageRoute(builder: (context) => AdminDashboard()));
      } else {
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) => Dashboard(user),
          ),
        );
      }
    });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
