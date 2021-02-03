import 'package:flutter/material.dart';
import 'package:login_register_first/Models/MyUser.dart';
import 'package:login_register_first/Utilities/snackbar.dart';
import 'package:login_register_first/services/user_management.dart';

class UserDetails extends StatefulWidget {
  final MyUser user;

  UserDetails(this.user);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  var _fullNameController = TextEditingController();

  List _roles = ["admin", "user"];
  List _permissions = ["edit", "view"];
  List<DropdownMenuItem<String>> _dropDownMenuItemsRole,
      _dropDownMenuItemsPermission;
  String _currentRole, _currentPermission;

  @override
  void initState() {
    _fullNameController.text = widget.user.fullname;
    _currentRole = widget.user.role;
    _currentPermission = widget.user.permission;
    _dropDownMenuItemsRole = getDropDownMenuItems(_roles);
    _dropDownMenuItemsPermission = getDropDownMenuItems(_permissions);
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems(List _list) {
    List<DropdownMenuItem<String>> items = new List();
    for (String l in _list) {
      items.add(new DropdownMenuItem(value: l, child: new Text(l)));
    }
    return items;
  }

  _edit(BuildContext ctx) {
    if (_currentPermission == widget.user.permission &&
        _currentRole == widget.user.role &&
        _fullNameController.text == widget.user.fullname) {
      MyUtilities.showSnackbar(
          ctx, "Please change the details and press the Edit button");
    } else {
      MyUtilities.showSnackbar(ctx, "Successfully edited the User!");
      Map<String, dynamic> maps = new Map<String, dynamic>();
      maps['u_id'] = widget.user.id;
      maps['full_name'] = _fullNameController.text;
      maps['role'] = _currentRole;
      maps['permission'] = _currentPermission;
      UserManagement().editUser(maps, ctx);
    }
  }

  _delete(BuildContext ctx) {
    UserManagement().deleteUser(widget.user.id, ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.username + "\'s profile"),
        centerTitle: true,
        actions: [
          Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _delete(ctx);
              },
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 60,
                child: Center(
                  child: Text(
                    "Edit Details",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
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
                    controller: _fullNameController,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    "Please choose a Role: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: DropdownButton(
                      elevation: 16,
                      items: _dropDownMenuItemsRole,
                      value: _currentRole,
                      onChanged: (value) {
                        setState(() {
                          _currentRole = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "Please choose a Permission: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: DropdownButton(
                      elevation: 16,
                      items: _dropDownMenuItemsPermission,
                      value: _currentPermission,
                      onChanged: (value) {
                        setState(() {
                          _currentPermission = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  width: 160,
                  height: 50,
                  child: Builder(
                    builder: (ctx) => RaisedButton(
                      color: Colors.purple.shade400,
                      child: Text("Edit",
                          style: TextStyle(fontSize: 30, color: Colors.white)),
                      onPressed: () {
                        _edit(ctx);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
