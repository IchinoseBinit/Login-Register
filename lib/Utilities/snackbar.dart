import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_register_first/Models/ToDo.dart';

class MyUtilities {

  static List<ToDo> list = new List<ToDo>();
  
  static void showSnackbar(BuildContext ctx, String text) {
    final snackBar = SnackBar(content: Text(text));
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    Scaffold.of(ctx).showSnackBar(snackBar);
  }
}
