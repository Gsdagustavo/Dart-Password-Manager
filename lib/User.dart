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

  // return an User if the user exists, otherwise returns null
  static User? checkIfUserExists(String username, List<User> users) {

    for (User user in users) {
      if (username == user.username) {

        // user exists
        return user;
      }
    }

    // user does not exist
    return null;
  }
}