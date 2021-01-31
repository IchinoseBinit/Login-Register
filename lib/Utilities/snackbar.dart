import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySnackbar {
  static void showSnackbar(BuildContext ctx, String text) {
    final snackBar = SnackBar(content: Text(text));
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    Scaffold.of(ctx).showSnackBar(snackBar);
  }
}
