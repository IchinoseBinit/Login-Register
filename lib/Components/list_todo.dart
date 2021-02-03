import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_register_first/Models/MyUser.dart';
import 'package:login_register_first/Models/ToDo.dart';
import 'package:login_register_first/Utilities/snackbar.dart';
import 'package:login_register_first/services/todo_management.dart';

class ToDoList extends StatefulWidget {
  final List<ToDo> list = MyUtilities.list;

  final MyUser user;

  ToDoList(this.user);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  _deleteToDo(String id, BuildContext ctx) {
    if (widget.user.permission == "edit") {
      ToDoManagement().removeFromToDo(id, ctx);
    } else {
      MyUtilities.showSnackbar(
          ctx, "Access Denied, You do not have the permission to edit ToDos!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ToDoManagement().getToDos(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  title: Text(
                    document['title'],
                    style: Theme.of(context).textTheme.bodyText1
                  ),
                  subtitle: Text(document['user_name']),
                  trailing: MediaQuery.of(context).size.width > 500
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              _deleteToDo(document.id, context),
                          textColor: Theme.of(context).errorColor,
                          label: Text('Delete'),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              _deleteToDo(document.id, context),
                          color: Theme.of(context).errorColor,
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
    );
  }
}
