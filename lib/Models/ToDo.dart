class ToDo {
  String _uid;
  String _username;
  String _title;

  ToDo(this._uid, this._username, this._title);

  ToDo.fromMap(dynamic obj){
    this._uid = obj['u_Id'];
    this._username = obj['user_name'];
    this._title = obj['title'];
  }

  String get uId => _uid;
  String get username => _username;
  String get title => _title;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['uId'] = _uid;
    map["user_name"] = _username;
    map['title'] = _title;
    
    return map;
  }
}