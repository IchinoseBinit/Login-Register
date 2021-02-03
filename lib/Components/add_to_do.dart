import 'package:flutter/material.dart';
import 'package:login_register_first/Models/MyUser.dart';
import 'package:login_register_first/Models/ToDo.dart';
import 'package:login_register_first/services/todo_management.dart';

class AddToDo extends StatefulWidget {
  final MyUser user;
  final BuildContext ctx;

  AddToDo(this.user, this.ctx);

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final _titleController = TextEditingController();

  void addToDo(BuildContext ctx) {
    var title = _titleController.text.trim();
    if (title.isEmpty) {
      return;
    } else {
      ToDo toDo = new ToDo(widget.user.id, widget.user.username, title);
      ToDoManagement().addToDos(toDo.toMap(), ctx);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                width: 300,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.title),
                      labelText: 'Title *',
                      hintText: "Enter the title of the To-Do"
                    ),
                    controller: _titleController,
                    onSaved: (String value) {},
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Please input the title';
                      } else if (value.trim().length < 4) {
                        return 'Title must contains more than 4 letters.';
                      }
                      return "";
                    },
                  ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 180,
                height: 60,
                child: RaisedButton(
                    color: Colors.purple,
                    child: Text("Add To-Do",
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    onPressed: () {
                      addToDo(widget.ctx);
                    },
                  ),
                ),   
            ],
          ),
        ),
      ),
    );
  }
}
