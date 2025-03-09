import 'dart:io';

class Password {
  String? _password;
  int? _id;
  List<String>? _tags;

  Password(this._password, this._id);

  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  List<String> get tags => _tags!;

  void addTag(String tag) {
    if (tag.isNotEmpty) {
      tags.add(tag);
    }
  }
}

class User {
  String? _username;
  String? _password;
  int? _id;

  User(this._username, this._password, this._id);

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

  while (input == null || input.isEmpty) {
    stdout.write('invalid input, try again: ');
    input = stdin.readLineSync();
  }

  return input;
}

void printList(list) {
  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }
}