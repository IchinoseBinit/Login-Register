import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:login_register_first/Utilities/snackbar.dart';

class ToDoManagement {
  Stream<QuerySnapshot> getToDos() {
    // FirebaseFirestore.instance.collection("todo").doc(user.user.uid).get().then((value) {;
    return FirebaseFirestore.instance.collection('todo').snapshots();
    // CollectionReference todo = FirebaseFirestore.instance.collection('todo');
    // todo.get().then((querySnapshot) {
    //   print("query: "+querySnapshot.docs.length.toString());
    //   for (QueryDocumentSnapshot qd in querySnapshot.docs) {
    //     ToDo td = ToDo.fromMap(qd.data());
    //     MyUtilities.list.add(td);
    //   }
    //   print(MyUtilities.list.length);
    // });
  }

  removeFromToDo(String uid, BuildContext ctx) {
    CollectionReference todo = FirebaseFirestore.instance.collection('todo');
    todo.doc(uid).delete().then((_) {
      MyUtilities.showSnackbar(ctx, "Successfully Deleted the todo!");
    });
  }

  addToDos(Map<String, dynamic> maps, BuildContext ctx) {
    CollectionReference todo = FirebaseFirestore.instance.collection('todo');

    todo.doc().set(
        {'user_name': maps['user_name'], 'title': maps['title']}).then((value) {
      Navigator.of(ctx).pop();
      MyUtilities.showSnackbar(ctx, "To Do Added");
    }).catchError((error) {
      Navigator.of(ctx).pop();
      MyUtilities.showSnackbar(ctx, "Failed to Add another To Do");
    });
  }
}
