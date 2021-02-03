
class MyUser {
  String _id;
  String _fullName;
  String _email;
  String _username;
  String _role;
  String _permission;

  MyUser(this._id, this._fullName, this._email, this._username, this._role, this._permission);

  MyUser.fromMap(dynamic obj) {
    this._id = obj['u_id'];
    this._fullName = obj['full_name'];
    this._email = obj['email_address'];
    this._username = obj['user_name'];
    this._role = obj['role'];
    this._permission = obj['permission'];
  }

  String get id => _id;
  String get fullname => _fullName;
  String get email => _email;
  String get username => _username;
  String get role => _role;
  String get permission => _permission;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['fullname'] = _fullName;
    map['email'] = _email;
    map["username"] = _username;
    map['role'] = _role;
    map['permission'] = _permission;
    
    return map;
  }
}