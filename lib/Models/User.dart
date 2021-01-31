class User {
  int _id;
  String _fullName;
  String _email;
  String _username;
  String _password;

  User(this._id, this._fullName, this._email, this._username, this._password);

  User.fromMap(dynamic obj) {
    print(obj);
    this._id = obj['id'];
    this._fullName = obj['fullname'];
    this._email = obj['email'];
    this._username = obj['username'];
    this._password = obj['password'];
  }

  int get id => _id;
  String get fullname => _fullName;
  String get email => _email;
  String get username => _username;
  String get password => _password;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['fullname'] = _fullName;
    map['email'] = _email;
    map["username"] = _username;
    map["password"] = _password;
    
    return map;
  }
}