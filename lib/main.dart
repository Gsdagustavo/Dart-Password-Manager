import 'dart:io';

class Password {

  // attributes
  String? _password;
  int? _id;
  List<String>? _tags;

  // constructor
  Password(this._password, this._id);

  // getters and setters
  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  List<String> get tags => _tags!;

  // function that adds a tag to the tags list
  void addTag(String tag) {

    if (tag.isNotEmpty) {
      if (!tags.contains(tag)) {
        tags.add(tag);
      } else {
        print('tag $tag already exists on the list');
      }
    } else {
      print('invalid tag');
    }
  }
}

class User {

  // attributes
  String? _username;
  String? _password;
  int? _id;

  // constructor
  User(this._username, this._password, this._id);

  // getters and setters
  int get id => _id!;

  set id(int value) {
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

List<User>? users;
User? loggedUser;
bool loggedIn = false;

void main() {

}

void tryLogin(String username, String password) {
  User? user = checkIfUserExists(username);

  // check if the user exists
  if (user != null) {

    // check if user password is the same as the entered password
    if (password == user.password) {

      // logged in
      loggedIn = true;
      loggedUser = user;
      print('logged in successfully');
      return;
    } else {

      // password incorrect for the user
      print('invalid password for user $username');
      return;
    }
  } else {

    // user does not exist
    print('user $username does not exist');
    return;
  }
}

// return an User if the user exists, otherwise returns null
User? checkIfUserExists(String username) {

  for (User user in users!) {
    if (username == user.username) {

      // user exists
      return user;
    }
  }

  // user does not exist
  return null;
}

String getStringInput() {
  String? input = stdin.readLineSync();

  // try to get a string input while the actual input is invalid
  while (input == null || input.isEmpty) {
    stdout.write('invalid input, try again: ');
    input = stdin.readLineSync();
  }

  return input;
}

// prints a list
void printList(list) {
  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }
}