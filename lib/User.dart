class User {

  // attributes
  String? _username;
  String? _password;
  String? _id;

  // constructor
  User(this._username, this._password, this._id);

  // getters and setters
  String get id => _id!;

  set id(String value) {
    _id = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  String get username => _username!;

  set username(String value) {
    _username = value;
  }
}